class RenameDateUpdate < ActiveRecord::Migration
  def up
  	rename_column :gas, :date_update, :date
  end

  def down
  end
end
