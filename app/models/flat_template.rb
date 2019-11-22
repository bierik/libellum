class FlatTemplate < ApplicationRecord
  validates_presence_of :name, :price

  scope :ordered, -> { order(:name) }
end
