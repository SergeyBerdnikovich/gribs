class ChangeCategoryType < ActiveRecord::Migration
  def change
  	change_column  :gas_catalog_standards, :categories, :string
  end
end
