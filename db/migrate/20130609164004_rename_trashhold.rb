class RenameTrashhold < ActiveRecord::Migration
  def up
  	rename_column :notifications, :trashhold_notification, :treshhold_notification
  	rename_column :notifications, :trashhold, :treshhold
  end

  def down
  end
end
