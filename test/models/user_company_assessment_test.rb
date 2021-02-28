require 'test_helper'

class UserCompanyAssessmentTest < ActiveSupport::TestCase
  test 'user receives a notification after his first appointment in a company' do
    Appointment.create(start_date: (Time.current - 1.day) + 1.hour, end_date: (Time.current - 1.day) + 2.hour, user_id: 1, company_id: 2)
    Appointment.create_user_company_assessment
    assert :success
  end
end
