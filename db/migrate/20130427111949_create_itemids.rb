class CreateItemids < ActiveRecord::Migration
  def change
    create_table :itemids do |t|
      t.string :itemid

      t.timestamps
    end
  end
end
