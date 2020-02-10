class Task < ApplicationRecord
  include Organizationable

  belongs_to :customer

  validates_presence_of :rrule, :duration, :title

  scope :ordered, -> { order(:rrule) }

  FORT_NIGHTLY = :FORT_NIGHTLY

  FREQUENCIES = [
    ['Nie', ''],
    ['Täglich', :DAILY],
    ['Wöchentlich', :WEEKLY],
    ['Alle zwei Wochen', FORT_NIGHTLY],
    ['Monatlich', :MONTHLY],
  ].freeze

  def time_reported
    ActiveSupport::Duration.build(reports.to_a.sum(0, &:time_reported).round).iso8601
  end

  def report_price
    (time_reported / (60 * 60)) * customer.price_per_hour
  end

  def as_json(*)
    super.merge(time_reported: time_reported, recurring: recurring?)
  end

  def recurring?
    false
  end
end
