class CreateRsr < ActiveRecord::Migration
  def change
    create_table :rsr do |t|
      t.integer :product_id
      t.integer :date
      t.integer :qty
    end

    add_index :rsr , :product_id
    add_index :rsr , :date
    add_index :rsr , :qty
  end

end
