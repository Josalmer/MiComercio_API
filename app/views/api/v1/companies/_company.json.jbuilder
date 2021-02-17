json.id company.id
json.name company.name
json.averagePuntuation company.average_company_puntuation
json.fistAvailableAppointment company.fist_available_appointment
json.published company.published
json.logo company.logo
json.type company.type
json.category company.category
json.diaryClientLimit company.diary_client_limit
json.monthlyClientLimit company.monthly_client_limit
json.simultaneousNumber company.simultaneous_appointment_number
json.appointmentDuration company.appointment_duration
json.web company.web
json.mail company.mail
json.phone company.phone
json.description company.description
json.validated company.user.validated_manager
json.pendingUserAssessment company.pending_user_assessment(current_api_v1_user.id)
json.address do
  json.partial! 'api/v1/addresses/address', address: company.address if company.address&.direction != company.name
end
json.hours company.company_hours do |hour|
  json.partial! 'api/v1/company_hours/company_hour', company_hour: hour
end
json.specialSchedules company.special_schedules.not_finished do |schedule|
  json.partial! 'api/v1/special_schedules/special_schedule', special_schedule: schedule
end
json.assessments company.user_company_assessments.filled.ordered_by_filled_date_asc do |assessment|
  json.partial! 'api/v1/assessments/assessment', assessment: assessment
end
