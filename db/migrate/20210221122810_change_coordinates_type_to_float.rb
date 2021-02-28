class ChangeCoordinatesTypeToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :latitude, :decimal, precision: 14, scale: 10
    change_column :addresses, :longitude, :decimal, precision: 14, scale: 10
  end
end
