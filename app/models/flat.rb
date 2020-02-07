class Flat < ApplicationRecord
  include Organizationable

  belongs_to :customer

  validates_presence_of :name, :price
end
