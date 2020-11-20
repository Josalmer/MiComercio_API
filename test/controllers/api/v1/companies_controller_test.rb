require 'test_helper'

class Api::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'index function gives companies data' do
    user = users(:user)
    sign_up(user)
    get '/api/v1/companies', headers: @jsonHeaders
    assert_response :success
  end

  test 'show function gives specific company data' do
    user = users(:user)
    sign_up(user)
    company = companies(:one)
    get "/api/v1/companies/#{company.id}", headers: @jsonHeaders
    assert_response :success
  end

  test 'manager_companies function gives manager companies data' do
    user = users(:manager)
    sign_up(user)
    get '/api/v1/manager_companies', headers: @jsonHeaders
    assert_response :success
  end

  test 'success when creating new company' do
    user = users(:manager)
    sign_up(user)
    post '/api/v1/companies', as: :json, headers: @json_headers, params: {
      created_company_object: {
        name: 'testing company name',
        company_type: 1
      }
    }
    assert_response :success
  end

  test 'error when creating new company with same name as other' do
    user = users(:manager)
    sign_up(user)
    post '/api/v1/companies', as: :json, headers: @json_headers, params: {
      created_company_object: {
        name: 'company test1',
        company_type: 1
      }
    }
    assert_response :not_acceptable
  end

  test 'error when creating new company as normal user' do
    user = users(:user)
    sign_up(user)
    post '/api/v1/companies', as: :json, headers: @json_headers, params: {
      created_company_object: {
        name: 'testing company name',
        company_type: 1
      }
    }
    assert_response 422
  end

  test 'success when updating a company' do
    user = users(:manager)
    sign_up(user)
    patch '/api/v1/companies/1', as: :json, headers: @json_headers, params: {
      edited_company_object: {
        name: 'testing company name 2'
      },
      edited_direction_object: {
        province: 'Granada'
      }
    }
    assert_response :success
  end

  test 'error when updating a company as normal user' do
    user = users(:user)
    sign_up(user)
    patch '/api/v1/companies/1', as: :json, headers: @json_headers, params: {
      edited_company_object: {
        name: 'testing company name 2'
      },
      edited_direction_object: {
        province: 'Granada'
      }
    }
    assert_response 422
  end

  test 'success when updating a company image' do
    user = users(:manager)
    sign_up(user)
    image = fixture_file_upload('files/bar.jpg', 'image/jpeg', :binary)
    image_base64 = Base64.strict_encode64(File.read(image.path))
    myme_type = 'data:image/png;base64,'
    image_base64 = myme_type + image_base64
    patch '/api/v1/company_image/1', as: :json, headers: @json_headers, params: {
      logo: image_base64
    }
    assert_response :success
  end

  test 'error when updating a file as company image' do
    user = users(:manager)
    sign_up(user)
    image = fixture_file_upload('files/bar.jpg', 'image/jpeg', :binary)
    image_base64 = Base64.strict_encode64(File.read(image.path))
    myme_type = 'data:application/pdf;base64,'
    image_base64 = myme_type + image_base64
    patch '/api/v1/company_image/1', as: :json, headers: @json_headers, params: {
      logo: image_base64
    }
    assert_response :unprocessable_entity
  end
end
