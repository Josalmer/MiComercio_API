class Notification < ApplicationRecord
  require 'fcm'
  validates :user, :title, :summary, presence: true
  belongs_to :user

  scope :by_user, ->(user) { where(user_id: user) }

  after_create :send_notification

  private

  def send_notification
    fcm_client = FCM.new(Rails.application.credentials.fcm_server_key)
    options = {
      data: { message: summary },
      notification: {
        title: title,
        body: summary,
        sound: 'default'
      },
      android: {
        notification: {
          default_sound: true,
          default_light_settings: true,
          default_vibrate_timings: true
        }
      }
    }

    user.device_tokens.pluck(:token).each do |token|
      response = fcm_client.send(token, options)
      puts response if response[:status_code] != 200
    end
  end
end
