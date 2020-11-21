class CompanyHour < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :special_schedule, optional: true
  enum day: %i[sunday monday tuesday wednesday thursday friday saturday]

  scope :by_day, ->(day) { where(day: day) }
  scope :ordered_by_opening_time, -> { order 'opening_time ASC' }

  validate :belongs_to_company_or_schedule, :check_not_overlapping, :closing_time_after_opening

  private

  def belongs_to_company_or_schedule
    errors.add(:error, I18n.t('custom.only_company_or_schedule')) if company && special_schedule
  end

  def check_not_overlapping
    other_hours = company ? company.company_hours.by_day(day) : special_schedule.company_hours.by_day(day)

    other_hours.each do |other_hour|
      if opening_time < other_hour.closing_time && closing_time > other_hour.opening_time
        errors.add(:error, I18n.t('custom.not_overlap_hours'))
      end
    end
  end

  def closing_time_after_opening
    errors.add(:error, I18n.t('custom.closing_time_after_opening')) if opening_time >= closing_time
  end
end
