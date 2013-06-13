class AddIndexesNew < ActiveRecord::Migration
  def up
    add_index :products, :manufacturer_id
    add_index :products, :item_id
    add_index :products, :upc_or_ean_id

    add_index :gas , :product_id
    add_index :gas , :date_update
    add_index :gas , :qty
  end

  def down
  end
end
