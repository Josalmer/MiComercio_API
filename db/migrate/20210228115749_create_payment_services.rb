class CreatePaymentServices < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_services do |t|
      t.belongs_to :user, index: true
      t.belongs_to :company, index: true
      t.string :service
      t.float :cost
      t.boolean :payed, null: false, default: false

      t.timestamps
    end
  end
end
