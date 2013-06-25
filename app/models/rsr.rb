class Rsr < ActiveRecord::Base
	set_table_name "rsr"
  belongs_to :product
  attr_accessible :date, :product_id, :qty
end
