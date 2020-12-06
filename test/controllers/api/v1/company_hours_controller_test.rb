require 'test_helper'

class Api::V1::CompanyHoursControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
    user = users(:user)
    sign_up(user)
  end

  test 'new company_hours is created ok if everything is right' do
    post '/api/v1/company_hours', as: :json, headers: @jsonHeaders, params: {
      company_id: 1,
      day: 2,
      opening_time: '00:00',
      closing_time: '00:05'
    }
    assert_response :success
  end

  test 'error when creating company_hours with wrong hours' do
    post '/api/v1/company_hours', as: :json, headers: @jsonHeaders, params: {
      company_id: 1,
      day: 2,
      opening_time: '00:05',
      closing_time: '00:00'
    }
    assert_response :not_acceptable
  end

  test 'error when creating company_hours with overlapping hours' do
    post '/api/v1/company_hours', as: :json, headers: @jsonHeaders, params: {
      company_id: 1,
      day: 2,
      opening_time: '00:00',
      closing_time: '01:00'
    }
    post '/api/v1/company_hours', as: :json, headers: @jsonHeaders, params: {
      company_id: 1,
      day: 2,
      opening_time: '00:05',
      closing_time: '00:30'
    }
    assert_response :not_acceptable
  end

  test 'success when deleting opening hours' do
    delete '/api/v1/company_hours/1', as: :json, headers: @jsonHeaders
    assert_response :success
  end
end
