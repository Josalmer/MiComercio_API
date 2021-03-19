class Company < ApplicationRecord
  include Attachable

  validates :name, presence: true, uniqueness: true
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many :company_hours, dependent: :destroy
  has_many :favorite_companies, dependent: :destroy
  has_many :special_schedules, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :user_company_assessments, dependent: :destroy
  has_many :payment_services, dependent: :destroy
  has_many :offers, dependent: :destroy
  belongs_to :company_type

  scope :by_manager, ->(id) { where(user_id: id) }
  scope :publisheds, -> { where(published: true) }
  scope :ordered_by_boost, -> { order 'boost_factor DESC' }
  scope :boosted, -> { where.not(boost_validity: nil) }

  delegate :category, to: :company_type
  delegate :type, to: :company_type

  validate :validate_user_is_manager, :check_limit

  after_create :create_address

  def to_s
    name
  end

  def logo
    file_url
  end

  def self.by_type(type)
    all.select { |a| a.type == type }
  end

  def self.by_category(category)
    all.select { |a| a.category == category }
  end

  def simultaneous_number
    simultaneous_appointment_number.present? && simultaneous_appointment_number.positive? ? simultaneous_appointment_number : 1
  end

  def duration
    appointment_duration.present? && appointment_duration.positive? ? appointment_duration : 15
  end

  def opening_days
    company_hours.pluck('day').uniq
  end

  def pending_user_assessment(user_id)
    user_company_assessments.by_user(user_id).pending.any?
  end

  def average_company_puntuation
    n = user_company_assessments.filled.count
    if n > 0
      total = 0
      total += user_company_assessments.filled.sum(:puntuality)
      total += user_company_assessments.filled.sum(:attention)
      total += user_company_assessments.filled.sum(:satisfaction)
      average = (total / (n * 3.0)).round
    else
      0
    end
  end

  def fist_available_appointment
    if opening_days.any?
      current_checking_day = Time.current.beginning_of_day
      limit = current_checking_day + 6.month
      loop do
        first_appointment = check_day(current_checking_day)
        return first_appointment if first_appointment

        current_checking_day += 1.day
        break if current_checking_day >= limit
      end
    end
  end

  def self.check_finished_boost
    Company.boosted.each do |company|
      company.update_columns(boost_factor: 0, boost_validity: nil) if company.boost_validity < Time.current
    end
  end

  private

  def check_limit
    if diary_client_limit.negative? || monthly_client_limit.negative?
      # :nocov:
      errors.add(:error, I18n.t('errors.custom.limit_must_be_0_or_higher'))
      # :nocov:
    end
  end

  def validate_user_is_manager
    errors.add(:error, I18n.t('custom.organization_manager_validation')) if user && !user.organization_manager
  end

  def create_address
    Address.create(company_id: id, direction: name)
  end

  def check_day(day)
    hours = []
    if special_schedules.not_finished.by_date(day).any?
      # :nocov:
      schedule = special_schedules.not_finished.by_date(day).first
      hours = schedule.company_hours.where(day: day.wday)
      # :nocov:
    else
      hours = company_hours.where(day: day.wday)
    end
    if hours.any?
      hours.each do |hour|
        first_appointment = check_hour(day, hour)
        return first_appointment if first_appointment
      end
    end
    false
  end

  def check_hour(day, hour)
    appointments_number = (((hour.closing_time - hour.opening_time) / 60) / duration).ceil
    appointments_number.times do |order_number|
      start_time = day
      end_time = day
      opening_time = hour.opening_time + (order_number * duration).minutes
      closing_time = opening_time + duration.minutes
      closing_time = hour.closing_time if closing_time > hour.closing_time
      start_time = start_time.change({ hour: opening_time.hour, min: opening_time.min })
      end_time = end_time.change({ hour: closing_time.hour, min: closing_time.min })
      if start_time >= Time.current
        first_appointment = check_appointment(start_time, end_time)
        return first_appointment if first_appointment
      end
    end
    # :nocov:
    false
    # :nocov:
  end

  def check_appointment(start_time, end_time)
    current_appointments = appointments.active.by_start_and_end_date(start_time, end_time).count
    current_appointments < simultaneous_number ? { start: start_time, end: end_time } : false
  end
end
