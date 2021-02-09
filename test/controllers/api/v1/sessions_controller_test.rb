require 'test_helper'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    @json_headers = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'user can sign_in with email and password' do
    post '/api/v1/users/sign_in', as: :json,
                                  headers: @json_headers,
                                  params: { api_v1_user: { email: @user.email, password: '123456' } }
    assert_response :success
  end

  test 'user can sign_in with social_token' do
    post '/api/v1/users/sign_in', as: :json,
                                  headers: @json_headers,
                                  params: { api_v1_user: { provider: 'GOOGLE', social_token: 'correct_social_token' } }
    assert_response :success
  end

  test 'user cannot sign_in with bad email or password' do
    post '/api/v1/users/sign_in', as: :json,
                                  headers: @json_headers,
                                  params: { api_v1_user: { email: @user.email, password: 'bad_password' } }
    assert_response :unauthorized
  end

  test 'user cannot sign_in with bad social_token' do
    post '/api/v1/users/sign_in', as: :json,
                                  headers: @json_headers,
                                  params: { api_v1_user: { provider: 'GOOGLE', social_token: 'unexisting_social_token' } }
    assert_response :unauthorized
  end

  test 'no content on response when signed out' do
    sign_in @user
    delete '/api/v1/users/sign_out'
    assert_equal '', response.body
  end
end
