class Task < ApplicationRecord
  FORT_NIGHTLY = :FORT_NIGHTLY
  FREQUENCIES = [
    ['Nie', ''],
    ['Täglich', :DAILY],
    ['Wöchentlich', :WEEKLY],
    ['Alle zwei Wochen', FORT_NIGHTLY],
    ['Monatlich', :MONTHLY],
  ].freeze

  include Organizationable

  belongs_to :customer

  validates_presence_of :rrule, :duration, :title
  validates :frequency, inclusion: { in: FREQUENCIES.map(&:last).map(&:to_s) }
  validate :datetime do |task|
    datetime = Time.zone.parse(@datetime)
    raise ArgumentError if datetime.blank?
  rescue ArgumentError
    task.errors.add(:datetime, 'Ungültiges Datum')
  end

  scope :ordered, -> { order(:rrule) }

  attr_accessor :frequency, :datetime

  def generate_rrule
    self.rrule = "DTSTART;TZID=#{Rails.application.config.time_zone}:#{rrule_datetime}\n#{rrule_frequency}"
  end

  def time_reported
    ActiveSupport::Duration.build(reports.to_a.sum(0, &:time_reported).round).iso8601
  end

  def report_price
    (time_reported / (60 * 60)) * customer.price_per_hour
  end

  def rrule_frequency
    if frequency == Task::FORT_NIGHTLY.to_s
      'FREQ=WEEKLY;INTERVAL=2'
    elsif frequency.blank?
      'COUNT=1'
    else
      "FREQ=#{frequency}"
    end
  end

  def rrule_datetime
    I18n.l(Time.zone.parse(datetime), format: :rrule)
  end
end
