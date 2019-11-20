class ApplicationController < ActionController::Base
  if Rails.env.production?
    http_basic_authenticate_with(
      name: Rails.application.credentials.dig(:basic_auth, :username),
      password: Rails.application.credentials.dig(:basic_auth, :password)
    )
  end
end
