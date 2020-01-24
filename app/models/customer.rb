class Customer < ApplicationRecord
  include Organizationable

  has_many :tasks, dependent: :destroy
  has_many :flats, through: :tasks, dependent: :destroy
  has_many :reports, through: :tasks, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates_presence_of :firstname, :lastname, :street, :number, :place, :zip

  scope :ordered, -> { order(:lastname, :firstname) }

  def calculate_route_flat!
    calculate_distance!
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

  private

  def calculate_distance!
    self.distance = Rails.application.config.google_maps_service.new(
      organization.directions_api_address,
      directions_api_address,
      language: Google::Maps.default_language,
    ).distance.value
  end

end
