require 'test_helper'

class Api::V1::PaymentServicesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
    user = users(:manager)
    sign_up(user)
  end

  test 'success when boosting a company' do
    patch '/api/v1/boost_company', as: :json, headers: @json_headers, params: {
      company_id: 1,
      cost: 20,
      duration: 5,
      boost_factor: 15
    }
    assert_response :success
  end

  test 'success when creating a offer' do
    patch '/api/v1/create_offer', as: :json, headers: @json_headers, params: {
      company_id: 1,
      validity: 20,
      discount: 5,
      text: "test"
    }
    assert_response :success
  end
end
