class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :company
      t.belongs_to :user
      t.boolean :created_by_manager, default: false
      t.string :user_name
      t.string :user_phone
      t.datetime :requested_at
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :finished_at
      t.datetime :removed_at

      t.timestamps
    end
  end
end
