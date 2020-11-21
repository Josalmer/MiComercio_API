class CreateCompanyHours < ActiveRecord::Migration[6.0]
  def change
    create_table :company_hours do |t|
      t.belongs_to :company
      t.belongs_to :special_schedule
      t.integer :day, null: false
      t.time :opening_time, null: false
      t.time :closing_time, null: false

      t.timestamps
    end
  end
end
