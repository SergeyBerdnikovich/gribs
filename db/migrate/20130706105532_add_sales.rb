class AddSales < ActiveRecord::Migration
	def change
		add_column :gas, :sales, :integer
		add_index :gas, :sales

		add_column :rsr, :sales, :integer
		add_index :rsr, :sales
	end
end
