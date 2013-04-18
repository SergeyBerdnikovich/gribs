class Product < ActiveRecord::Base
  attr_accessible :active_status, :categories, :date, :extended_description, :height, :images, :item_id, :length, :manufacturer_item_id, :msrp, :qty_available, :retail_map, :stock_status, :stock_status, :upc_or_ean_id, :weight, :width, :manufacturer , :product_name , :short_description
end
