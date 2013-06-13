class AddIndexes < ActiveRecord::Migration
  def up
  	  add_index :itemids, :itemid
  end

  def down
  end
end
