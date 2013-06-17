class RsrInventory < ActiveRecord::Base
  attr_accessible :AllocatedCloseoutDeleted, :DepartmentNumber, :ExpandedProductDescription, :FullManufacturerName, :Imagename, :InventoryQuantity, :ManufacturerId, :ManufacturerPartNumber, :Model, :ProductDescription, :ProductWeight, :RSRRegularPrice, :RSRStockNumber, :RetailPrice, :UPCCode
end
