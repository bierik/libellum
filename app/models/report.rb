class Report < ApplicationRecord
  include Organizationable

  belongs_to :customer

  validates_presence_of :start_at

  def time_reported
    if end_at.nil?
      Time.zone.now - start_at
    else
      end_at - start_at
    end
  end

  def price
    (time_reported / (60 * 60)) * customer.price_per_hour
  end

  def round_price
    (round_seconds_reported / (60.0 * 60.0)) * customer.price_per_hour
  end

  def round_time_reported
    Time.at(round_seconds_reported).utc.strftime('%H:%M')
  end

  def round_seconds_reported
    organization.report_invoice_round * (time_reported / organization.report_invoice_round).round
  end
end
