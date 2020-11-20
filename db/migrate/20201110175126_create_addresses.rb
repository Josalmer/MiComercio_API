class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.belongs_to :company
      t.integer :cp
      t.string :town
      t.string :province
      t.string :country
      t.string :direction

      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
