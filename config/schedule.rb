# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every '0 19 * * *', output: 'log/check_and_send_diary_notifications.log' do
  runner 'Appointment.check_and_send_diary_notifications'
end

every '0 19 * * 0', output: 'log/check_and_send_weekly_notifications.log' do
  runner 'Appointment.check_and_send_weekly_notifications'
end

every '0 21 * * 0', output: 'log/create_user_company_assessment.log' do
  runner 'Appointment.create_user_company_assessment'
end

every 5.minutes, output: 'log/check_and_send_hourly_notification.log' do
  runner 'Appointment.check_and_send_hourly_notification'
end

every '0 1 * * *', output: 'log/check_finished_boost.log' do
  runner 'Company.check_finished_boost'
end
