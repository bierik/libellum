class Customer < ApplicationRecord
  include Organizationable

  has_many :tasks, dependent: :destroy
  has_many :flats, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates_presence_of :first_name, :last_name, :street, :number, :place, :zip
  validates :color, length: { is: 7 }

  scope :ordered, -> { order(:last_name, :first_name) }

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

  def address
    "#{street} #{number}, #{zip} #{place}"
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def bright_color?
    @bright_color ||= Color::RGB.by_hex(color).brightness > 0.7
  end

  private

  def calculate_distance!
    self.distance = Rails.application.config.google_maps_service.new(
      organization.address,
      address,
      language: Google::Maps.default_language,
    ).distance.value
  end
end
