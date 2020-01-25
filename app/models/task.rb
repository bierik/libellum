class Task < ApplicationRecord
  include Organizationable

  belongs_to :customer

  validates_presence_of :start

  default_scope { order(start: :asc) }

  scope :between, ->(from, to) { where('start >= ? AND start <= ?', from, to) }

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
