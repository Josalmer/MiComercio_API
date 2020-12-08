class CreateDeviceTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :device_tokens do |t|
      t.belongs_to :user, index: true
      t.string :token

      t.timestamps
    end
  end
end
