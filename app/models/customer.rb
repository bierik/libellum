class Customer < ApplicationRecord
  include Organizationable

  has_many :tasks, dependent: :destroy
  has_many :flats, through: :tasks, dependent: :destroy
  has_many :reports, through: :tasks, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates_presence_of :firstname, :lastname, :street, :number, :place, :zip

  def calculate_distance!
    self.distance = google_maps_service.directions(
      Settings.instance.directions_api_address,
      directions_api_address,
    )
  end

  def calculate_route_flat!
    self.route_flat = case distance
                      when 0..5_000
                        5
                      when 5_000..8_000
                        8
                      when 8_000..10_000
                        10
                      when 10_000..12_000
                        12
                      when 12_000..15_000
                        15
                      when 15_000..18_000
                        18
                      else
                        20
                      end
  end

  def directions_api_address
    "#{street} #{number}, #{zip} #{place}"
  end

  def google_maps_service
    Rails.application.config.google_maps_service
  end
end
