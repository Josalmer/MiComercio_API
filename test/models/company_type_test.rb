require 'test_helper'

class CompanyTypeTest < ActiveSupport::TestCase
  test 'company_type has to_s' do
    type = company_types(:one)
    type.to_s
    assert :success
  end
end
