require 'test_helper'

class Api::V1::SocialLoginControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @jsonHeaders = { "Accept": 'application/json', "Content-Type": 'application/json' }
  end

  test 'user can create an account via social login with google' do
    post '/api/v1/social_login',  as: :json,
                                  headers: @json_headers,
                                  params: { 
                                    provider: 'GOOGLE',
                                    social_token: 'unexisting_social_token',
                                    email: 'unexisting@mail.com',
                                    name: 'test',
                                    surname: 'test'
                                  }
    assert_response :success
  end

  test 'user can associate an existing account via social login with google' do
    post '/api/v1/social_login',  as: :json,
                                  headers: @json_headers,
                                  params: { 
                                    provider: 'GOOGLE',
                                    social_token: '123123',
                                    email: 'email2@mail.com',
                                    name: 'test',
                                    surname: 'test'
                                  }
    assert_response :success
  end

  test 'user can authenticate himself via social login with google' do
    post '/api/v1/social_login',  as: :json,
                                  headers: @json_headers,
                                  params: { 
                                    provider: 'GOOGLE',
                                    social_token: 'correct_social_token',
                                    email: 'unexisting@mail.com',
                                    name: 'test',
                                    surname: 'test'
                                  }
    assert_response :success
  end
end
