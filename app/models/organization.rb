class Organization < ApplicationRecord
  validates :handle, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
