require 'test_helper'

class Api::V1::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'index function gives user appointments' do
    user = users(:user)
    sign_up(user)
    get '/api/v1/appointments', headers: @jsonHeaders
    assert_response :success
  end

  test 'index function gives manager appointments' do
    user = users(:manager)
    sign_up(user)
    get '/api/v1/appointments', headers: @jsonHeaders
    assert_response :success
  end

  test 'get appointments for company function gives user appointments for this company' do
    user = users(:user)
    sign_up(user)
    get '/api/v1/user_appointments_for_company/1', headers: @jsonHeaders
    assert_response :success
  end

  test 'get company appointments gives all appointments for that company' do
    user = users(:manager)
    sign_up(user)
    get '/api/v1/company_appointments/1', headers: @jsonHeaders, params: {
      date: Time.current.to_time.iso8601
    }
    assert_response :success
  end

  test 'success when creating new appointment' do
    user = users(:user)
    sign_up(user)
    post '/api/v1/appointments', as: :json, headers: @json_headers, params: {
      company_id: 1,
      created_by_manager: false,
      start_date: Time.current.to_time.iso8601,
      end_date: (Time.current + 10).to_time.iso8601
    }
    assert_response :success
  end

  test 'error when creating new appointment with wrong data' do
    user = users(:user)
    sign_up(user)
    post '/api/v1/appointments', as: :json, headers: @json_headers, params: {
      company_id: 2,
      created_by_manager: false,
      start_date: Time.current.to_time.iso8601
    }
    assert_response :not_acceptable
  end

  test 'error when creating new appointment and reached limit' do
    user = users(:user)
    appointment = appointments(:one)
    sign_up(user)
    post '/api/v1/appointments', as: :json, headers: @json_headers, params: {
      company_id: 1,
      created_by_manager: false,
      start_date: appointment.start_date,
      end_date: appointment.end_date
    }
    assert_response :not_acceptable
  end

  test 'success when cancelling an appointment as user' do
    user = users(:user)
    sign_up(user)
    patch '/api/v1/cancel_appointment/2', as: :json, headers: @json_headers
    assert_response :success
  end

  test 'success when cancelling an appointment as manager' do
    manager = users(:manager)
    sign_up(manager)
    patch '/api/v1/cancel_appointment/2', as: :json, headers: @json_headers
    assert_response :success
  end

  test 'error when cancelling an appointment that not exists' do
    user = users(:user)
    sign_up(user)
    appointment = appointments(:two)
    appointment.update_columns(end_date: nil)
    patch '/api/v1/cancel_appointment/2', as: :json, headers: @json_headers
    assert_response :not_acceptable
  end
end
