class Api::V1::GoogleCalendarEventsController < Api::BaseController
  def export_appointments
    @user = current_api_v1_user
    if @user.organization_manager
      @user.companies.each do |company|
        company.appointments.active.pending.manager_export_pending.each do |appointment|
          appointment.export_google_calendar(true)
        end
      end
    else
      @user.appointments.active.pending.user_export_pending.each do |appointment|
        appointment.export_google_calendar(false)
      end
    end
    head 200
  end
end
