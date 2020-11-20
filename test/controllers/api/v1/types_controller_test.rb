require 'test_helper'

class Api::V1::TypesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    sign_up(@user)
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'index function gives types data' do
    get '/api/v1/types', headers: @jsonHeaders
    assert_response :success
  end
end
