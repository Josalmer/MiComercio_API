class DeviceToken < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  belongs_to :user

  def to_s
    token = id.to_s
    token = "#{user} device: #{token}" if user
    token
  end
end
