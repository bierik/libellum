class FlatTemplate < ApplicationRecord
  include Organizationable

  validates_presence_of :name, :price

  scope :ordered, -> { order(:name) }
end
