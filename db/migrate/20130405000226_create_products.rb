class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :date
      t.string :item_id
      t.string :manufacturer_item_id
      t.string :upc_or_ean_id
      t.string :extended_description
      t.string :images
      t.string :weight
      t.string :length
      t.string :width
      t.string :height
      t.string :categories
      t.string :retail_map
      t.string :msrp
      t.string :stock_status
      t.integer :qty_available
      t.string :stock_status
      t.string :active_status

      t.timestamps
    end
  end
end
