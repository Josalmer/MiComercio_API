class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.belongs_to :company, index: true
      t.string :text
      t.float :discount
      t.datetime :validity

      t.timestamps
    end
  end
end
