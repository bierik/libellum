class Organization < ApplicationRecord
  validates :handle, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  has_and_belongs_to_many :users
end
