class AddFieldsToGasCostStandards < ActiveRecord::Migration
  def change
    add_column :gas_cost_standards, :retail_map, :string
    add_column :gas_cost_standards, :msrp, :string
  end
end
