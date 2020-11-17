class CreatePaymentPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_preferences do |t|
      t.belongs_to :user, index: true
      t.string :type
      t.string :number
      t.string :bank
      t.string :expiration_month
      t.string :expiration_year
      t.boolean :validated, null: false, default: false

      t.timestamps
    end
  end
end
