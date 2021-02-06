class AddSocialLoginToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :social_token, :text
  end
end
