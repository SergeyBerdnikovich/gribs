class CreateGasInventoryStandards < ActiveRecord::Migration
  def change
    create_table :gas_inventory_standards do |t|
      t.string :item_id
      t.integer :qty_available
      t.string :stock_status
      t.string :active_status
    end
  end
end
