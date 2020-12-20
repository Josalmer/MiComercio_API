class CreateNotificationPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_preferences do |t|
      t.belongs_to :user, index: true
      t.boolean :active, null: false, default: true

      t.boolean :user_1_week_before, null: false, default: true
      t.boolean :user_1_day_before, null: false, default: true
      t.boolean :user_1_hour_before, null: false, default: true
      t.boolean :user_when_manager_cancel_appointment, null: false, default: true

      t.boolean :manager_appointment_requested, null: false, default: true
      t.boolean :manager_appointment_cancelled, null: false, default: true

      t.timestamps
    end
  end
end
