require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test 'weekly reminder send notifications' do
    Appointment.create(start_date: (Time.current + 1.day).beginning_of_day + 1.hour, end_date: (Time.current + 1.day).beginning_of_day + 2.hour, user_id: 1, company_id: 1)
    Appointment.check_and_send_weekly_notifications
    assert :success
  end

  test 'diary reminder send notifications' do
    Appointment.create(start_date: (Time.current + 1.day).beginning_of_day + 1.hour, end_date: (Time.current + 1.day).beginning_of_day + 2.hour, user_id: 1, company_id: 1)
    Appointment.check_and_send_diary_notifications
    assert :success
  end

  test 'hourly reminder send notifications' do
    Appointment.create(start_date: Time.current + 62.minutes, end_date: Time.current + 72.minutes, user_id: 1, company_id: 1)
    Appointment.check_and_send_hourly_notification
    assert :success
  end
end
