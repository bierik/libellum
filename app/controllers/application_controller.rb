class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :current_organization
  before_action :check_organization_access, unless: :devise_controller?

  private
  def check_organization_access
    current_organization.users.include?(current_user)
  end

  def current_organization
    @current_organization ||= Organization.find_by!(handle: request.subdomain)
  end

  def current_context; end
  helper_method :current_context
end
