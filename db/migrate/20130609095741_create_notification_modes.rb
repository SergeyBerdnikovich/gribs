class CreateNotificationModes < ActiveRecord::Migration
  def change
    create_table :notification_modes do |t|
      t.string :name

      t.timestamps
    end
  end
end
