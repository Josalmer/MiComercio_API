require 'test_helper'

class Api::V1::AssessmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
    user = users(:user)
    sign_up(user)
  end

  test 'index function gives user assessments' do
    get '/api/v1/assessments', headers: @jsonHeaders
    assert_response :success
  end

  test 'update function fill user assessment for a company' do
    patch '/api/v1/assessments/1', as: :json, headers: @json_headers, params: {
      company_id: 1,
      text: 'lorem ipsum',
      puntuality: 2,
      attention: 3,
      satisfaction: 2
    }
    assert_response :success
  end

  test 'get company gives it average puntuation and its assessmments' do
    UserCompanyAssessment.create(company_id: 1, user_id: 2, puntuality: 2, satisfaction: 2, attention: 2, filled_at: Time.current)
    get "/api/v1/companies/1", headers: @jsonHeaders
    assert_response :success
  end
end
