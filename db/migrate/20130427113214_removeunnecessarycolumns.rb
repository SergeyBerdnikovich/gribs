class Removeunnecessarycolumns < ActiveRecord::Migration
  def up
  	remove_column :itemids, :updated_at
  	remove_column :itemids, :created_at
  end

  def down
  end
end
