class CreateGasCatalogStandards < ActiveRecord::Migration
  def change
    create_table :gas_catalog_standards do |t|
t.string :item_id
t.string :manufacturer_item_id
t.string :upc_or_ean_id
t.string :manufacturer
t.string :product_name
t.string :short_description
t.string :extended_description
t.string :images
t.column :weight, :float
t.column :length, :float
t.column :width, :float
t.column :height, :float
t.integer :categories
t.string :retail_map
t.string :msrp
t.string :stock_status
    end
  end
end
