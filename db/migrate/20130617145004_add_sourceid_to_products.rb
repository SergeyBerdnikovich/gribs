class AddSourceidToProducts < ActiveRecord::Migration
  def change
    add_column :products, :source_id, :integer
  end
end
