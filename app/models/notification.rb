class Notification < ActiveRecord::Base
  attr_accessible :emails, :start_qty, :start_qty_notification, :treshhold, :treshhold_notification, :notification_mode_id

  belongs_to :notification_mode
end
