class Api::V1::CalendarEventsController < Api::BaseController
  before_action :load_data
  respond_to :json

  def index
    @events = []
    load_events
  end

  private

  def load_events
    days_number = ((@to - @from) / (24 * 60 * 60)).to_i + 1
    days_number.times do |day|
      current_day = @from + day.day
      load_day_events(current_day)
    end
  end

  def load_day_events(day)
    week_days = %w[sunday monday tuesday wednesday thursday friday saturday]
    @day_events = []
    if @company.special_schedules.not_finished.by_date(day).any?
      load_from_special_schedule(day, @company.special_schedules.not_finished.by_date(day).first)
    elsif @company.opening_days.include? week_days[day.wday]
      load_from_company_schedule(day)
    end
  end

  def load_from_special_schedule(day, special_schedule)
    unless special_schedule.closed
      hours = special_schedule.company_hours.where(day: day.wday)
      hours.each do |hour|
        load_hour_events(day, hour)
      end
    end
  end

  def load_from_company_schedule(day)
    hours = @company.company_hours.where(day: day.wday)
    hours.each do |hour|
      load_hour_events(day, hour)
    end
  end

  def load_hour_events(day, hour)
    appointments_number = (((hour.closing_time - hour.opening_time) / 60) / @company.duration).ceil
    appointments_number.times do |order_number|
      start_time = day
      end_time = day
      opening_time = hour.opening_time + (order_number * @company.duration).minutes
      closing_time = opening_time + @company.duration.minutes
      closing_time = hour.closing_time if closing_time > hour.closing_time
      start_time = start_time.change({ hour: opening_time.hour, min: opening_time.min })
      end_time = end_time.change({ hour: closing_time.hour, min: closing_time.min })
      @events << CalendarEvent.new(@company, start_time, end_time)
    end
  end

  def load_data
    @company = Company.find(params_permit['id'])
    @from = Time.zone.iso8601(params_permit['from'])
    @to = Time.zone.iso8601(params_permit['to'])
  end

  def params_permit
    params.permit(:id, :from, :to)
  end
end
