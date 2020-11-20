class PaymentPreference < ApplicationRecord
  belongs_to :user
  enum payment_type: %i[card bank]

  def to_s
    "#{payment_type}: #{id}"
  end
end
