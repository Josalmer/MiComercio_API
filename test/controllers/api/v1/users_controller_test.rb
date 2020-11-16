require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    sign_up(@user)
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'index function gives user data' do
    get '/api/v1/user', headers: @jsonHeaders
    assert_response :success
  end

  test 'success when updating user profile' do
    patch '/api/v1/user', as: :json, headers: @json_headers, params: { name: 'test' }
    assert_response :success
  end

  test 'failure when updating user profile with wrong data' do
    patch '/api/v1/user', as: :json, headers: @json_headers, params: { email: 'wrong_email' }
    assert_response :not_acceptable
  end
end
