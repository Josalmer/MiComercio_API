class Offer < ApplicationRecord
  belongs_to :company
  validates :text, presence: true
  validates :validity, presence: true

  scope :active, -> { where('validity > ?', Time.current.beginning_of_day) }

  scope :ordered_by_validity, -> { order 'validity ASC' }

  def send_notifications
    users = company.appointments.map(&:user).uniq
    users.each do |user|
      if user&.notification_preference&.active && user&.device_tokens.any?
        notification_params = {
          user_id: user.id
        }
        notification_params = notification_params.merge(offer_notifications_params)
        notification = Notification.new(notification_params)
        notification.save
      end
    end
  end

  private

  def offer_notifications_params
    {
      title: I18n.t('notifications.offer.title', company: company.name),
      summary: text
    }
  end
end
