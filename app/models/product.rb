class Product < ActiveRecord::Base
  attr_accessible :extended_description, :height, :images, :item_id, :length, :manufacturer, :manufacturer_item_id, :product_name, :short_description, :upc_or_ean_id, :weight, :width

  has_one :gas
  belongs_to :manufacturer

  search_methods :upc_or_ean_id_contains, :upc_or_ean_id_starts_with, :upc_or_ean_id_ends_with

  scope :upc_or_ean_id_contains, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("category_id LIKE '%?%'", category_id)
  }
  scope :upc_or_ean_id_starts_with, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("category_id LIKE '?%'", category_id)
  }

  scope :upc_or_ean_id_ends_with, lambda { |category_id|
    Product.joins(:upc_or_ean_id).where("category_id LIKE '%?'", category_id)
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
    end

      cost = cost.to_i if cost != nil
      cost = 0 if cost == nil
    @source = Source.find(source_id)
    percent_threshold = percent_threshold.to_f
    #products = Product.find_by_sql("SELECT item_id,manufacturer_item_id, upc_or_ean_id, product_name, manufacturer, qty_available, date FROM products WHERE (date = #{period_start} OR date = #{period_end}) AND qty_available>#{begin_qty} ORDER BY product_name")
    products = Product.find_by_sql("SELECT product_id, qty, date FROM #{@source.db_name} WHERE (date = #{period_start} OR date = #{period_end}) AND qty > #{begin_qty}")
    prodarr = Hash.new
    products.each do |product|
      qty_available = product.qty
      if qty_available < 0
        qty_available = 0
      end
      if prodarr[product.product_id] == nil
        #prodarr[product.product_id] = [product.manufacturer_product_id, product.upc_or_ean_id, product.product_name, product.manufacturer, qty_available,nil,product.date]
        prodarr[product.product_id] = [product.product_id, nil, nil, nil, qty_available,nil,product.date]
      else
        if product.date > prodarr[product.product_id][6]
          bval = prodarr[product.product_id][4]
          eval = qty_available
        else
          eval = prodarr[product.product_id][4]
          bval = qty_available
        end
        prodarr[product.product_id][8] = bval
        prodarr[product.product_id][9] = eval
        # below is debug
        # prodarr[product.product_id][7] = "bval = #{bval}, eval = #{eval}, d1 = #{prodarr[product.product_id][6]}, d2 = #{product.date} " # debug row
        if bval != 0  #to solve NaN
          percent =   (((eval - bval) / bval.to_f) * 100.0)
        else
          percent = 100
        end
        if (percent_threshold >= 0)
          if percent > percent_threshold
            prodarr[product.product_id][5] = '%.0f' % percent
          else
            prodarr.delete(product.product_id)
          end
        else
          if percent < percent_threshold
            prodarr[product.product_id][5] = '%.0f' % percent
          else
            prodarr.delete(product.product_id)
          end
        end
      end
    end
    prodarr.collect  do |k,product|
      @tp = Product.find(product[0])
      #[product.manufacturer_product_id, product.upc_or_ean_id, product.product_name, product.manufacturer, qty_available,nil,product.date]
      #prodarr[product.product_id] = [product.product_id, nil, nil, nil, qty_available,nil,product.date]
      @tp.cost = 0 if @tp.cost == nil
      if @tp.cost >=  cost  #implementing cost filter
        product[0] = @tp.manufacturer_item_id
        product[1] = @tp.upc_or_ean_id
        product[2] = @tp.product_name
        product[3] = @tp.manufacturer.name
        product[10] = '%.0f' % @tp.cost
        product[11] = @tp.id
      else
        prodarr.delete(k)
      end


    end

    return prodarr

  end
end
