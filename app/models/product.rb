class Product < ActiveRecord::Base
  attr_accessible :extended_description, :height, :images, :item_id, :length, :manufacturer, :manufacturer_item_id, :product_name, :short_description, :upc_or_ean_id, :weight, :width

  has_many :gass
  has_many :rsr
  belongs_to :manufacturer

  search_methods :upc_or_ean_id_contains, :upc_or_ean_id_starts_with, :upc_or_ean_id_ends_with, :upc_or_ean_id_equals

  scope :upc_or_ean_id_equals, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("upc_or_ean_id = '?'", category_id)
  }


  scope :upc_or_ean_id_contains, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("upc_or_ean_id LIKE '%?%'", category_id)
  }
  scope :upc_or_ean_id_starts_with, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("upc_or_ean_id LIKE '?%'", category_id)
  }

  scope :upc_or_ean_id_ends_with, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("upc_or_ean_id LIKE '%?'", category_id)
  }

  def self.to_csv(source_id,period_start, period_end, begin_qty, percent_threshold, cost)
    CSV.generate(:col_sep => ";") do |csv|
      csv << ["Item SKU",
        "Item UPC",
        "Item Name",
        "Item Brand",
      "Percent"]

      if period_start && period_end
        @products = Product.filter(source_id,period_start.gsub(/\//, ''), period_end.gsub(/\//, ''), begin_qty, percent_threshold)
      else
        @products = []
      end

      @products.each do |key,product|
        if product[5] != nil
          csv << [product[0],product[1],product[2],product[3],product[5]]
        end
      end
    end
  end



  def self.filter(source_id,period_start, period_end, begin_qty, percent_threshold, cost = 0)
    if begin_qty == nil
      begin_qty = 0
    else
      begin_qty = begin_qty.to_i
    end

    cost = cost.to_i if cost != nil
    cost = 0 if cost == nil
    @source = Source.find(source_id)
    percent_threshold = percent_threshold.to_f
    products = ActiveRecord::Base.connection.execute("SELECT bvals.date, bvals.product_id, bvals.qty AS beginval, evals.endval as endval  FROM gas bvals LEFT JOIN (SELECT gas.qty AS endval, gas.product_id  FROM gas WHERE date = #{period_end}) evals ON (bvals.product_id = evals.product_id) WHERE bvals.date = #{period_start} AND bvals.qty >= #{begin_qty};")
    #products = Product.find_by_sql("SELECT product_id, qty, date FROM #{@source.db_name} WHERE (date = #{period_start} OR date = #{period_end}) AND product_id IN (SELECT product_id FROM #{@source.db_name} WHERE date = #{period_start} AND qty >= #{begin_qty}) ")
    prodarr = Hash.new
    products.each do |product|
      if prodarr[product[1]] == nil
        prodarr[product[1]] = [product[1], nil, nil, nil, product[2],nil,product[0]]
        bval  = product[2]
        eval = product[3]
        eval = 0 if eval == nil
        prodarr[product[1]][8] = bval
        prodarr[product[1]][9] = eval
        # below is debug
        # prodarr[product[1]][7] = "bval = #{bval}, eval = #{eval}, d1 = #{prodarr[product[1]][6]}, d2 = #{product.date} " # debug row
        if bval != 0  #to solve NaN
          percent =   (((eval - bval) / bval.to_f) * 100.0)
        else
          percent = 100
        end
        if (percent_threshold >= 0)
          if percent > percent_threshold
            prodarr[product[1]][5] = '%.0f' % percent
          else
            prodarr.delete(product[1])
          end
        else
          if percent < percent_threshold
            prodarr[product[1]][5] = '%.0f' % percent
          else
            prodarr.delete(product[1])
          end
        end
      end
    end
    i = 0
    retarr = Hash.new
    prodarr.collect do |k,product|
      @tp = Product.find(product[0])
      if product[8].to_i >= begin_qty #begin quantity filter
        @tp.cost = 0 if @tp.cost == nil
        if @tp.cost >=  cost  #implementing cost filter
          i += 1
          # raise @tp.inspect if i == 2
          product[0] = @tp.manufacturer_item_id
          product[1] = @tp.upc_or_ean_id
          product[2] = @tp.product_name
          product[3] = @tp.manufacturer.name
          product[10] = '%.0f' % @tp.cost
          product[11] = @tp.id
          #raise product.inspect.to_s if i == 2
          retarr[k] = product
        end
      end

    end
    return retarr
  end


  def self.days_drop(start_date, days=2,trashhold, source)

    joins = " "
    selects = "todayvals.* "
    wheres  = "todayvals.qty > 0 AND todayvals.date = #{start_date} "

    days.to_i.times do |day|
      day += 1
      date = (DateTime.strptime(start_date,"%Y%m%d") - day.to_i.day).strftime("%Y%m%d")
      selects += ", #{day}dayvals.qty "
      joins += " LEFT JOIN (SELECT gas.qty, gas.product_id FROM gas WHERE date = #{date} and qty > 0) #{day}dayvals ON #{day}dayvals.product_id = todayvals.product_id "
      wheres += " AND ((todayvals.qty - #{day}dayvals.qty) / #{day}dayvals.qty) > #{trashhold} "
    end

    products = ActiveRecord::Base.connection.execute("SELECT #{selects} FROM gas todayvals #{joins} WHERE #{wheres} ;")
    #raise "SELECT #{selects} FROM gas todayvals #{joins} WHERE #{wheres} ;"

    return products.to_a

  end

end
