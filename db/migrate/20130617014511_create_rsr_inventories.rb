class CreateRsrInventories < ActiveRecord::Migration
  def change
    create_table :rsr_inventories do |t|
      t.string :RSRStockNumber
      t.string :UPCCode
      t.string :ProductDescription
      t.integer :DepartmentNumber
      t.string :ManufacturerId
      t.float :RetailPrice
      t.float :RSRRegularPrice
      t.float :ProductWeight
      t.integer :InventoryQuantity
      t.string :Model
      t.string :FullManufacturerName
      t.string :ManufacturerPartNumber
      t.string :AllocatedCloseoutDeleted
      t.text :ExpandedProductDescription
      t.text :Imagename

      t.timestamps
    end
  end
end
