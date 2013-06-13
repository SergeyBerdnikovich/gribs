class Renameitemid < ActiveRecord::Migration
  def up
  	rename_column :products, :item_id, :itemid
  	rename_column :items, :item, :itemid
  end

  def down
  end
end
