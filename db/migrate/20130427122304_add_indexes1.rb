class AddIndexes1 < ActiveRecord::Migration
  def up
  		  add_index :items, :item
  		  add_index :items, :id
  end

  def down
  end
end
