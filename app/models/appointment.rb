class Appointment < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true

  validates :company, :start_date, :end_date, presence: true

  scope :active, -> { where(finished_at: nil, removed_at: nil) }
  scope :not_cancelled, -> { where(removed_at: nil) }
  scope :pending, -> { where('start_date >= ?', Time.current.beginning_of_day) }

  scope :by_user, ->(id) { where(user_id: id) }
  scope :by_company, ->(id) { where(company_id: id) }
  scope :by_user_and_company, ->(user_id, company_id) { where(user_id: user_id, company_id: company_id) }

  scope :by_date, lambda { |date|
    where('start_date >= ? AND end_date <= ?',
          date.change({ hour: 0, min: 0, sec: 0 }), date.change({ hour: 23, min: 59, sec: 59 }))
  }
  scope :by_start_and_end_date, lambda { |start_date, end_date|
    where('start_date = ? AND end_date = ?', start_date, end_date)
  }
  scope :between_dates, lambda { |previous_date, after_date|
    where('start_date >= ? AND start_date <= ?', previous_date, after_date)
  }

  scope :ordered_by_start_date_asc, -> { order 'start_date ASC' }

  before_create :fill_appointment_data

  validate :check_month_limit, :check_day_limit, :check_concurrency, :created_by_manager_or_have_user, on: :create

  private

  def fill_appointment_data
    self.requested_at = Time.current
    unless created_by_manager
      self.user_name = "#{user.name} #{user.surname}"
      self.user_phone = user.phone
    end
  end

  def created_by_manager_or_have_user
    errors.add(:error, I18n.t('custom.created_by_manager_or_have_user')) if created_by_manager && user
  end

  def check_month_limit
    if user && company.monthly_client_limit&.positive?
      user_active_appointments = company.appointments.active.by_user(user.id).between_dates(start_date.beginning_of_month, start_date.end_of_month).count
      if user_active_appointments >= company.monthly_client_limit
        errors.add(:error, I18n.t('custom.company_monthly_limit_reached'))
      end
    end
  end

  def check_day_limit
    if user && company.diary_client_limit&.positive?
      user_active_appointments = company.appointments.active.by_user(user.id).by_date(start_date).count
      errors.add(:error, I18n.t('custom.company_diary_limit_reached')) if user_active_appointments >= company.diary_client_limit
    end
  end

  def check_concurrency
    current_appointments_at_time = company.appointments.active.by_start_and_end_date(start_date, end_date).count
    errors.add(:error, I18n.t('custom.no_appointment_available')) if current_appointments_at_time >= company.simultaneous_number
  end
end