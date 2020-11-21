json.appointments @appointments do |appointment|
  json.partial! 'api/v1/appointments/appointment', appointment: appointment
end
