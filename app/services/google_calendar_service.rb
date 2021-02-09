require 'googleauth'
require 'google/apis/calendar_v3'

class GoogleCalendarService

  class << self
  
    def service
      @service
    end
    
    def events
      authorize if @service.nil?
      @events ||= @service.list_events(calendar_id, max_results: 2500).items
    end

    def create_event(mail, appointment)
      authorize if @service.nil?
      event = Google::Apis::CalendarV3::Event.new(
        summary: "Cita en #{appointment.company.name}",
        location: appointment.company.name,
        start: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: appointment.start_date.to_datetime.rfc3339,
          time_zone: 'Europe/Madrid'
        ),
        end: Google::Apis::CalendarV3::EventDateTime.new(
          date_time: appointment.end_date.to_datetime.rfc3339,
          time_zone: 'Europe/Madrid'
        ),
        # attendees: [
        #   Google::Apis::CalendarV3::EventAttendee.new(
        #     email: mail
        #   )
        # ],
        reminders: Google::Apis::CalendarV3::Event::Reminders.new(
          use_default: true
        )
      )
      result = @service.insert_event(calendar_id, event)
    end
  
  private
  
    def calendar_id
      @calendar_id ||= Rails.application.credentials.calendar_id 
    end
  
    def authorize
      calendar = Google::Apis::CalendarV3::CalendarService.new
      calendar.client_options.application_name = 'MiComercio'
  
      # An alternative to the following line is to set the ENV variable directly 
      # in the environment or use a gem that turns a YAML file into ENV variables
      ENV['GOOGLE_APPLICATION_CREDENTIALS'] = "./google_api.json"
      scopes = [Google::Apis::CalendarV3::AUTH_CALENDAR]
      calendar.authorization = Google::Auth.get_application_default(scopes)
  
      @service = calendar
    end

  end

end