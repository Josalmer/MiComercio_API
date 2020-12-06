require 'test_helper'

class Api::V1::CalendarEventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
    user = users(:user)
    sign_up(user)
  end

  test 'index function gives user calendar events' do
    get '/api/v1/calendar_events', headers: @jsonHeaders, params: {
      id: 1,
      from: '2022-03-01 00:00:0'.to_time.iso8601,
      to: '2022-03-20 00:00:0'.to_time.iso8601
    }
    assert_response :success
  end

  test 'index function gives 0 hours when no company_hours' do
    get '/api/v1/calendar_events', headers: @jsonHeaders, params: {
      id: 2,
      from: '2022-03-01 00:00:0'.to_time.iso8601,
      to: '2022-03-20 00:00:0'.to_time.iso8601
    }
    assert_response :success
  end
end
