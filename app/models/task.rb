class Task < ApplicationRecord
  enum frequency: { never: 'never', daily: 'daily', weekly: 'weekly', fort_nightly: 'fort_nightly', monthly: 'monthly' }

  include Organizationable

  belongs_to :customer

  validates_presence_of :datetime, :duration, :title

  scope :ordered, -> { order(:datetime) }

  def rrule
    datetime = I18n.l(self.datetime, format: :rrule)
    rrule_frequency = if fort_nightly?
                        'FREQ=WEEKLY;INTERVAL=2'
                      elsif never?
                        'COUNT=1'
                      else
                        "FREQ=#{frequency.upcase}"
                      end
    "DTSTART;TZID=#{Rails.application.config.time_zone}:#{datetime}\n#{rrule_frequency}"
  end

  def self.selectable_frequencies
    Task.frequencies.keys.map { |frequency| [Task.human_attribute_name("frequency.#{frequency}"), frequency] }
  end

  def time_reported
    ActiveSupport::Duration.build(reports.to_a.sum(0, &:time_reported).round).iso8601
  end

  def report_price
    (time_reported / (60 * 60)) * customer.price_per_hour
  end
end
