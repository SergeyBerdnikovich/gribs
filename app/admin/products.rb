ActiveAdmin.register Product do
	filter :upc_or_ean_id, :as => :string, :label => "UPC or EAN ID"
	filter :item_id, :as => :string , :label => "item id"
	# 
	filter :cost
	filter :manufacturer_item_id, :as => :string , :label => "manufacturer item id"
	filter :manufacturer
	filter :product_name

	index do

		column "Item_id", :item_id
		column :manufacturer do |product|
			product.manufacturer.name
		end
		column 'Manufacturer item_id' ,:manufacturer_item_id
		column :upc_or_ean_id
		column :cost
		column :category
		column :product_name
		column :short_description
		column :extended_description
		column :images
		column :weight
		column :length
		column :width
		column :height
		actions
	end
end
