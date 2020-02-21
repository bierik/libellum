module Users
  class InvitationsController < Devise::InvitationsController
    before_action :require_inviter_to_be_admin!, only: [:new, :create]

    private
    def require_inviter_to_be_admin!
      redirect_to root_path unless current_user.admin
    end

    def invite_params
      devise_parameter_sanitizer.sanitize(:invite).merge(organizations: [current_organization])
    end

    def current_context
      'invitations'
    end
  end
end
