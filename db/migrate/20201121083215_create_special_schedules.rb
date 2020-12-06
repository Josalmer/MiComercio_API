class CreateSpecialSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :special_schedules do |t|
      t.belongs_to :company
      t.boolean :closed
      t.date :start_date
      t.date :end_date
      t.integer :simultaneous_appointment_number

      t.timestamps
    end
  end
end
