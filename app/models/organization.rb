class Organization < ApplicationRecord
  %i[customers flats flat_templates invoices reports tasks task_containers].each do |model|
    has_many model
  end

  validates :handle, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  has_and_belongs_to_many :users
end
