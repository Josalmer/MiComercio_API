require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'company has to_s' do
    company = Company.by_type('Bar')
    company = Company.by_category('Restauración')
    company.first.to_s
    assert :success
  end

  test 'check company boost validity works' do
    company = companies(:one)
    company.update_columns(boost_factor: 10, boost_validity: DateTime.tomorrow)
    Company.check_finished_boost
    assert :success
  end
end
