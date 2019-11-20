class Flat < ApplicationRecord
  belongs_to :task

  validates_presence_of :name, :price
end
