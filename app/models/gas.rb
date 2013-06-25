class Gas < ActiveRecord::Base
  belongs_to :product
  attr_accessible :date, :product_id, :qty
end
