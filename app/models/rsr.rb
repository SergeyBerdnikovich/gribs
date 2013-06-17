class Rsr < ActiveRecord::Base
	set_table_name "rsr"
  attr_accessible :date, :product_id, :qty
end
