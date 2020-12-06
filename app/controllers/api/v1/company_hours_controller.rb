class Api::V1::CompanyHoursController < Api::BaseController
  respond_to :json

  def create
    hour = CompanyHour.new(hour_params)

    if hour.save
      render partial: 'api/v1/company_hours/company_hour', locals: { company_hour: hour }
    else
      render json: hour.errors, status: :not_acceptable
    end
  end

  def destroy
    hour = CompanyHour.find(hour_id['id'])
    hour.destroy ? (head 200) : (head 422)
  end

  private

  def hour_id
    params.permit(:id)
  end

  def hour_params
    params.permit(:company_id, :special_schedule_id, :day, :opening_time, :closing_time)
  end
end
