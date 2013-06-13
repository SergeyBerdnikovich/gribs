class GasCatalogStandard < ActiveRecord::Base
  attr_accessible :extended_description, :item_id, :manufacturer, :manufacturer_item_id, :msrp, :product_name, :short_description, :stock_status, :upc_or_ean_id
end
