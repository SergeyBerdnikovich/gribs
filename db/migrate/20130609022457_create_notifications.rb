class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :trashhold_notification
      t.integer :trashhold
      t.boolean :start_qty_notification
      t.integer :start_qty
      t.string :emails

      t.timestamps
    end
  end
end
