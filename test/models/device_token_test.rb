require 'test_helper'

class DeviceTokenTest < ActiveSupport::TestCase
  test 'device_token has to_s' do
    device_token = device_tokens(:one)
    device_token.to_s
    assert :success
  end
end
