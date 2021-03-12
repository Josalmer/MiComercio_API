require 'test_helper'

class Api::V1::OffersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'index function gives offers for current user' do
    user = users(:user)
    sign_up(user)
    get '/api/v1/offers', headers: @jsonHeaders
    assert_response :success
  end

  test 'index function gives offers for current manager' do
    user = users(:manager)
    sign_up(user)
    get '/api/v1/offers', headers: @jsonHeaders
    assert_response :success
  end
end
