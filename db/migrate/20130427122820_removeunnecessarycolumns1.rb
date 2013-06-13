class Removeunnecessarycolumns1 < ActiveRecord::Migration
  def up
  	remove_column :items, :updated_at
  	remove_column :items, :created_at
  end

  def down
  end
end
