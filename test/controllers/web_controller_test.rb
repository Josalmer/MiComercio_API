require 'test_helper'

class Api::V1::WebControllerTest < ActionDispatch::IntegrationTest
  test "index function gives user data" do
    get '/'
    assert :success
  end
end