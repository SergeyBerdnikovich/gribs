class AddManufacturerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :manufacturer, :string
  end
end
