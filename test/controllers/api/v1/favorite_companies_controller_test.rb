require 'test_helper'

class Api::V1::FavoriteCompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user)
    sign_up(@user)
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'user can save a company in favorites' do
    post '/api/v1/favorite_companies', as: :json, headers: @jsonHeaders, params: {
      id: 1
    }
    assert_response :success
  end

  test 'user can remove a company from favorites' do
    FavoriteCompany.create(company_id: 1, user_id: 1)
    delete '/api/v1/favorite_companies/1', as: :json, headers: @jsonHeaders
    assert_response :success
  end
end
