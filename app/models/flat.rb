class Flat < ApplicationRecord
  include Organizationable

  belongs_to :task

  validates_presence_of :name, :price
end
