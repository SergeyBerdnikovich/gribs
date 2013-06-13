class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :item_id
      t.string :manufacturer_item_id
      t.string :upc_or_ean_id
      t.integer :manufacturer_id
      t.string :product_name
      t.string :short_description
      t.string :extended_description
      t.string :images
      t.float :weight
      t.float :length
      t.float :width
      t.float :height

      t.timestamps
    end
  end
end
