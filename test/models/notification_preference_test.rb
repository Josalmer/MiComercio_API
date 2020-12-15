require 'test_helper'

class NotificationPreferenceTest < ActiveSupport::TestCase
  test 'notification preferences has to_s' do
    preferences = notification_preferences(:one)
    preferences.to_s
    assert :success
  end
end
