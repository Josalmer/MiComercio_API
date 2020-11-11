class Company < ApplicationRecord
  include Attachable

  validates :name, presence: true, uniqueness: true
  belongs_to :user
  has_one :address, dependent: :destroy
  belongs_to :company_type

  scope :by_manager, ->(id) { where(user_id: id) }

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

  private

  def validate_user_is_manager
    errors.add(:error, I18n.t('custom.organization_manager_validation')) if user && !user.organization_manager
  end

  def create_address
    Address.create(company_id: id, direction: name)
  end
end
