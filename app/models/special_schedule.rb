class SpecialSchedule < ApplicationRecord
  belongs_to :company
  has_many :company_hours, dependent: :destroy

  scope :not_finished, -> { where('end_date > ?', Time.current) }

  scope :by_date, lambda { |date|
    where('start_date <= ? AND end_date >= ?',
          date.change({ hour: 0, min: 0, sec: 0 }), date.change({ hour: 23, min: 59, sec: 59 }))
  }

  validate :end_after_start, :check_not_overlapping, on: :create

  private

  def end_after_start
    errors.add(:error, I18n.t('custom.end_date_after_start')) if end_date < start_date
  end

  def check_not_overlapping
    other_schedules = company.special_schedules.not_finished

    other_schedules.each do |schedule|
      errors.add(:error, I18n.t('custom.not_overlap_dates')) if start_date <= schedule.end_date && end_date >= schedule.start_date
    end
  end
end
