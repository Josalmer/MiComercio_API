class AddExportedAtToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :exported_by_user, :datetime
    add_column :appointments, :exported_by_manager, :datetime
  end
end
