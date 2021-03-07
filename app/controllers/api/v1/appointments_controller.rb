class Api::V1::AppointmentsController < Api::BaseController
  respond_to :json

  def create
    appointment = Appointment.new(new_appointment_params)

    appointment.user_id = current_api_v1_user.id unless new_appointment_params['created_by_manager']
    if appointment.save
      appointment.create_manager_notification('manager_appointment_requested') unless new_appointment_params['created_by_manager']
      render partial: 'api/v1/appointments/appointment', locals: { appointment: appointment }
    else
      render json: appointment.errors, status: :not_acceptable
    end
  end

  def index
    if current_api_v1_user.organization_manager
      companies = current_api_v1_user.companies
      @appointments = []
      companies.each do |company|
        @appointments.concat(company.appointments.active.pending.ordered_by_start_date_asc)
      end
    else
      @appointments = current_api_v1_user.appointments.active.pending.ordered_by_start_date_asc
    end
  end

  def user_appointments_for_company
    @appointments = Appointment.active.pending.by_user_and_company(current_api_v1_user.id, id_permitted['id']).ordered_by_start_date_asc
    render :index
  end

  def company_appointments
    selected_day = Time.zone.iso8601(selected_date['date'])
    @appointments = Appointment.active.pending.by_company(id_permitted['id']).by_date(selected_day).ordered_by_start_date_asc
    render :index
  end

  def cancel_appointment
    appointment = Appointment.find(id_permitted['id'])

    if appointment.update(removed_at: Time.current)
      if current_api_v1_user == appointment.company.user && appointment.user
        appointment.create_user_notification('user_when_manager_cancel_appointment')
      else
        appointment.create_manager_notification('manager_appointment_cancelled')
      end
      head 200
    else
      head :not_acceptable
    end
  end

  private

  def id_permitted
    params.permit(:id)
  end

  def selected_date
    params.permit(:date)
  end

  def new_appointment_params
    params.permit(:company_id, :created_by_manager, :user_name, :user_phone, :start_date, :end_date)
  end
end
