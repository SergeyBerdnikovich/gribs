class GasInventoryStandard < ActiveRecord::Base
  attr_accessible :active_status, :item_id, :qty_available, :stock_status
end
