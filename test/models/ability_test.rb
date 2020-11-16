require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test 'user can not manage restricted models' do
    user = users(:user)
    ability = Ability.new(user)
    assert ability.cannot?(:manage, User.new)
  end

  test 'admin can manage restricted models' do
    admin = users(:admin)
    ability = Ability.new(admin)
    assert ability.can?(:manage, User.new)
  end
end
