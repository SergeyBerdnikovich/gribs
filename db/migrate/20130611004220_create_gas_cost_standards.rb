class CreateGasCostStandards < ActiveRecord::Migration
  def change
    create_table :gas_cost_standards do |t|
      t.string :item_id
      t.float :cost

      t.timestamps
    end
  end
end
