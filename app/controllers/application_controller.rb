class ApplicationController < ActionController::Base
  before_action :check_organization

  if Rails.env.production?
    http_basic_authenticate_with(
      name: Rails.application.credentials.dig(:basic_auth, :username),
      password: Rails.application.credentials.dig(:basic_auth, :password),
    )
  end

  private
  def check_organization
    Organization.find_by!(handle: request.subdomain)
  end
end
