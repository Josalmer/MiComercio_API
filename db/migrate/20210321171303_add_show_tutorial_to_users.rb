class AddShowTutorialToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :show_tutorial, :boolean, default: true
  end
end
