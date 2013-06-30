class DropUnnecessaryTables < ActiveRecord::Migration
  def up
  	drop_table :itemids
	drop_table :items
	drop_table :quantities
  end

  def down
  end
end
