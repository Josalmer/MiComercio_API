class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :payment_preference, dependent: :destroy
  has_one :notification_preference, dependent: :destroy
  has_many :companies
  has_many :appointments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :device_tokens, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,4}$\z/i }

  scope :admin, -> { where(admin: true) }
  scope :created_by_social_login, ->(provider) { where(provider: provider) }
  scope :by_email, ->(email) { where(email: email)}

  after_create :create_payment_preference, :create_notification_preference

  def to_s
    email
  end

  def full_name
    "#{name} #{surname}"
  end

  def validated_manager
    payment_preference && payment_preference.validated
  end

  private

  def create_payment_preference
    # :nocov:
    PaymentPreference.create(user_id: id) if organization_manager
    # :nocov:
  end

  def create_payment_preference
    NotificationPreference.create(user_id: id)
  end
end
