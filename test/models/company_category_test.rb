require 'test_helper'

class CompanyCategoryTest < ActiveSupport::TestCase
  test 'category has to_s' do
    category = company_categories(:one)
    category.to_s
    assert :success
  end
end
