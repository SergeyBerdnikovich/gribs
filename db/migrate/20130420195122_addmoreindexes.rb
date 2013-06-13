class Addmoreindexes < ActiveRecord::Migration
  def up
  	 add_index :products, :manufacturer_item_id
  	 add_index :products, :upc_or_ean_id
  	 add_index :products, :product_name
  end

  def down
  end
end
