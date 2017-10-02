class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  self.per_form_csrf_tokens = true

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
