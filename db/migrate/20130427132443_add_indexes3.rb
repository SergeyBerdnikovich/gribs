class AddIndexes3 < ActiveRecord::Migration
  def up
  	  	add_index :quantities, :item_id
  		add_index :quantities, :qty
  		add_index :quantities, :date
  end

  def down
  end
end
