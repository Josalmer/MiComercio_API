class AddAppointmentDataToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :simultaneous_appointment_number, :integer
    add_column :companies, :appointment_duration, :integer
    add_column :companies, :published, :boolean, null: false, default: false
  end
end
