class CreateCompanyTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :company_types do |t|
      t.string :company_type
      t.belongs_to :company_category

      t.timestamps
    end
  end
end
