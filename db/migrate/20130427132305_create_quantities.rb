class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.integer :item_id
      t.integer :qty
      t.integer :date
    end
  end
end
