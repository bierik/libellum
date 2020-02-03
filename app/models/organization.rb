class Organization < ApplicationRecord
  %i[customers flats flat_templates invoices reports tasks].each do |model|
    has_many model
  end

  has_and_belongs_to_many :users

  validates :handle, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street, presence: true
  validates :zip, presence: true
  validates :place, presence: true
  validates :price_per_hour, presence: true

  def address
    "#{street} #{number}, #{zip} #{place}"
  end
end
