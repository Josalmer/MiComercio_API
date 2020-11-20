class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.belongs_to :user, index: true
      t.references :company_type
      t.string :name, null: false
      t.integer :diary_client_limit, null: false, default: 1
      t.integer :monthly_client_limit, null: false, default: 0
      t.string :web
      t.string :mail
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
