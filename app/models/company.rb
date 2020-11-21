class Company < ApplicationRecord
  include Attachable

  validates :name, presence: true, uniqueness: true
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many :company_hours, dependent: :destroy
  has_many :special_schedules, dependent: :destroy
  belongs_to :company_type

  scope :by_manager, ->(id) { where(user_id: id) }
  scope :publisheds, -> { where(published: true) }

  delegate :category, to: :company_type
  delegate :type, to: :company_type

  validate :validate_user_is_manager

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

  private

  def check_limit
    return unless diary_client_limit.negative? || monthly_client_limit.negative?

    errors.add(:error, I18n.t('errors.custom.limit_must_be_0_or_higher'))
  end

  def validate_user_is_manager
    errors.add(:error, I18n.t('custom.organization_manager_validation')) if user && !user.organization_manager
  end

  def create_address
    Address.create(company_id: id, direction: name)
  end
end
