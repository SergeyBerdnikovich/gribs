ActiveAdmin.register Gas do
   menu :parent => "Sources"
    filter :product_item_id, as: :string, :label => 'Product Item_id'
    filter :date
   	filter :qty
index do
   column "product_id"
   column "item_id" do |rsr|
   	rsr.product.item_id
   end
   column "date"
   column "qty"
     default_actions
end
end
