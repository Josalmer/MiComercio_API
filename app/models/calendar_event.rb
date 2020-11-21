class CalendarEvent
  attr_accessor :from, :to, :busy_slot, :total_slot
  def initialize(company, from, to)
    @from = from
    @to = to
    @busy_slot = calculate_busy(company, from, to)
    @total_slot = company.simultaneous_number
  end

  private

  def calculate_busy(company, from, to)
    company.appointments.active.by_start_and_end_date(from, to).count
  end
end
