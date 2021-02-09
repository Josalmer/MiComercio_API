require 'test_helper'

class Api::V1::GoogleCalendarEventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'user can export his appointments to google calendar' do
    user = users(:user)
    sign_up(user)
    patch '/api/v1/export_appointments', headers: @jsonHeaders
    assert_response :success
  end

  test 'manager can export his appointments to google calendar' do
    manager = users(:manager)
    sign_up(manager)
    patch '/api/v1/export_appointments', headers: @jsonHeaders
    assert_response :success
  end
end
