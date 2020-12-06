require 'test_helper'

class Api::V1::SpecialSchedulesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
    user = users(:user)
    sign_up(user)
  end

  test 'new special_schedule is created ok if everything is right' do
    post '/api/v1/special_schedules', as: :json, headers: @jsonHeaders, params: {
      company_id: 1,
      start_date: '2022-03-01',
      end_date: '2022-03-03'
    }
    assert_response :success
  end

  test 'error when special_schedule company_hours with wrong dates' do
    post '/api/v1/special_schedules', as: :json, headers: @jsonHeaders, params: {
      company_id: 1,
      start_date: '2022-03-03',
      end_date: '2022-03-01'
    }
    assert_response :not_acceptable
  end

  test 'success when deleting special schedules' do
    delete '/api/v1/special_schedules/1', as: :json, headers: @jsonHeaders
    assert_response :success
  end
end
