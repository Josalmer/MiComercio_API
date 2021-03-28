class CreateFavoriteCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_companies do |t|
      t.belongs_to :company
      t.belongs_to :user

      t.timestamps
    end
  end
end
