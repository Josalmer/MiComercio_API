class FavoriteCompany < ApplicationRecord
  belongs_to :company
  belongs_to :user

  scope :by_user, ->(id) { where(user_id: id) }
end
