require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'address has to_s' do
    address = addresses(:one)
    address.to_s
    assert :success
  end
end
