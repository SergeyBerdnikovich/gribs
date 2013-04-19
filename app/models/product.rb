class Product < ActiveRecord::Base
  attr_accessible :active_status, :categories, :date, :extended_description, :height, :images, :item_id, :length, :manufacturer_item_id, :msrp, :qty_available, :retail_map, :stock_status, :stock_status, :upc_or_ean_id, :weight, :width, :manufacturer , :product_name , :short_description

  def self.filter(period_start, period_end, percent_threshold)
    products = Product.where("date = ? OR date = ?", period_start, period_end)
                      .group_by(&:item_id)
                      .select {|item_id, products| products.size > 1}

    products.each do |item_id, products|
      products.map! do |product|
       [product.manufacturer_item_id, product.upc_or_ean_id, product.product_name, product.manufacturer, product.qty_available]
      end
    end
    products.each do |item_id, products|
      products[0] << ((products[1][4].to_f - products[0][4].to_f) / products[1][4] != 0 ? products[1][4].to_f : 1) * 100
    end

    products.select! {|item_id, products| products[0][5] > percent_threshold.to_f } unless percent_threshold.blank?

    products
  end
end
