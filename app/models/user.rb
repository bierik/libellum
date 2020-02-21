class User < ApplicationRecord
  devise :database_authenticatable, :invitable, :trackable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :organizations

  def self.find_for_authentication(warden_conditions)
    organization = Organization.find_by!(handle: warden_conditions[:subdomain])
    organization.users.where(email: warden_conditions[:email]).first
  end
end
