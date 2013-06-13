class Addmoreindexes3 < ActiveRecord::Migration
  def up
  	add_index :products, :item_id
  end

  def down
  end
end
