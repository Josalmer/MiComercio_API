class Api::V1::SpecialSchedulesController < Api::BaseController
  respond_to :json

  def create
    schedule = SpecialSchedule.new(schedule_params)

    if schedule.save
      render partial: 'api/v1/special_schedules/special_schedule', locals: { special_schedule: schedule }
    else
      render json: schedule.errors, status: :not_acceptable
    end
  end

  def destroy
    hour = SpecialSchedule.find(schedule_id['id'])
    hour.destroy ? (head 200) : (head 422)
  end

  private

  def schedule_id
    params.permit(:id)
  end

  def schedule_params
    params.permit(:company_id, :start_date, :end_date)
  end
end
