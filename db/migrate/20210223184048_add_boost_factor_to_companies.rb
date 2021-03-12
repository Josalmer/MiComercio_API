class AddBoostFactorToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :boost_factor, :integer, null: false, default: 0
    add_column :companies, :boost_validity, :datetime
  end
end
