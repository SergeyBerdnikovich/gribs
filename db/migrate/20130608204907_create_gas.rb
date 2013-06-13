class CreateGas < ActiveRecord::Migration
  def change
    create_table :gas do |t|
      t.integer :product_id
      t.integer :date_update
      t.integer :qty
    end
  end
end
