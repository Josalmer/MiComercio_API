require 'test_helper'

class Api::V1::DeviceTokensControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    sign_up(@user)
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'sucess when upload deviceToken if there are device token' do
    patch '/api/v1/device_tokens', as: :json, headers: @jsonHeaders, params: {
      device_token: 'holaquetal'
    }
    assert_response :success
  end

  test 'sucess when updateing a deviceToken if there are device token' do
    DeviceToken.create(user: @user, token: "holaquetal")
    patch '/api/v1/device_tokens', as: :json, headers: @jsonHeaders, params: {
      device_token: 'holaquetal'
    }
    assert_response :success
  end
end
