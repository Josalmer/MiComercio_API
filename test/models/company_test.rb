require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'company has to_s' do
    company = Company.by_type('Bar')
    company = Company.by_category('Restauración')
    company.first.to_s
    assert :success
  end
end
