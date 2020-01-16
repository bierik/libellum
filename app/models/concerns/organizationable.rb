module Organizationable
  extend ActiveSupport::Concern

  included do
    belongs_to :organization
  end
end
