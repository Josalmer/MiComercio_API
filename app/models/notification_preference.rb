class NotificationPreference < ApplicationRecord
  belongs_to :user

  def to_s
    "notification_preference: #{id}"
  end
end
