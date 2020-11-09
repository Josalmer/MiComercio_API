require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
  end

  test "user has to_s" do
    @user.to_s
    assert :success
  end
end
