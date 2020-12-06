json.id special_schedule.id
json.startDate special_schedule.start_date
json.endDate special_schedule.end_date
json.hours special_schedule.company_hours do |hour|
  json.partial! 'api/v1/company_hours/company_hour', company_hour: hour
end
