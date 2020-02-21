class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :current_organization
  before_action :check_organization_access, unless: :devise_controller?
  before_action :make_action_mailer_use_request_host_and_protocol
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # Allow setting first and last name
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :email])
  end

  private
  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def check_organization_access
    if !current_organization.users.include?(current_user) && !current_user.admin?
      sign_out(current_user)
      redirect_to new_user_session_path
    end
  end

  def current_organization
    @current_organization ||= Organization.find_by!(handle: request.subdomain)
  end

  def current_context; end
  helper_method :current_context
end
