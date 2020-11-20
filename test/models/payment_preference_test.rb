require 'test_helper'

class PaymentPreferenceTest < ActiveSupport::TestCase
  test 'payment_preference has to_s' do
    payment_preference = payment_preferences(:one)
    payment_preference.to_s
    assert :success
  end
end
