class AddNotificationmodeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :notification_mode_id, :integer
  end
end
