class UserCompanyAssessment < ApplicationRecord
  belongs_to :user
  belongs_to :company

  scope :by_user_and_company, ->(user_id, company_id) { where(user_id: user_id, company_id: company_id) }
  scope :by_user, ->(id) { where(user_id: id) }
  scope :by_company, ->(id) { where(company_id: id) }
  scope :filled, -> { where.not(filled_at: nil) }
  scope :pending, -> { where(filled_at: nil) }
  scope :ordered_by_filled_date_asc, -> { order 'filled_at ASC' }

  after_create :notify_user

  def average_puntuation
    ((puntuality + attention + satisfaction) / 3.0).round
  end

  private

  def notify_user
    if user&.notification_preference.active && user&.device_tokens.any?
      notification_params = {
        user_id: user.id,
        title: I18n.t('notifications.new_assessment_available.title', company: company.name),
        summary: I18n.t('notifications.new_assessment_available.summary', company: company.name)
      }
      notification = Notification.new(notification_params)
      notification.save
    end
  end
end
