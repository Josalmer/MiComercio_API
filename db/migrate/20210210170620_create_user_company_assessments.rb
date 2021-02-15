class CreateUserCompanyAssessments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_company_assessments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :company, index: true
      t.string :text
      t.integer :puntuality
      t.integer :attention
      t.integer :satisfaction
      t.datetime :filled_at

      t.timestamps
    end
  end
end
