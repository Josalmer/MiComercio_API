class CreateCompanyCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :company_categories do |t|
      t.string :category

      t.timestamps
    end
  end
end
