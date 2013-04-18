class AddUniqueIndexes < ActiveRecord::Migration
  def up

add_index :products, [:date, :item_id] , :unique => true 
  end

  def down
  end
end
