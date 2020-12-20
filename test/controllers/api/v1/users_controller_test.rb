require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'index function gives user data' do
    user = users(:user)
    sign_up(user)
    get '/api/v1/user', headers: @jsonHeaders
    assert_response :success
  end

  test 'success when updating user profile' do
    user = users(:user)
    sign_up(user)
    patch '/api/v1/user', as: :json, headers: @json_headers, params: { name: 'test' }
    assert_response :success
  end

  test 'failure when updating user profile with wrong data' do
    user = users(:user)
    sign_up(user)
    patch '/api/v1/user', as: :json, headers: @json_headers, params: { email: 'wrong_email' }
    assert_response :not_acceptable
  end

  test 'success when updating manager payment preferences' do
    user = users(:manager)
    sign_up(user)
    patch '/api/v1/update_manager_preferences', as: :json, headers: @json_headers, params: {
      newPaymentPreference: {
        payment_type: 1
      }
    }
    assert_response :success
  end

  test 'success when updating user notification preferences' do
    user = users(:user)
    sign_up(user)
    patch '/api/v1/update_notification_preferences', as: :json, headers: @json_headers, params: {
      newNotificationPreference: {
        active: 0
      }
    }
    assert_response :success
  end
end
