class PaymentPreference < ApplicationRecord
  belongs_to :user
  enum type: %i[card bank]

  def to_s
    "#{type}: #{id}"
  end
end
