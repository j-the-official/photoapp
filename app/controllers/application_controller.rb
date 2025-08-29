class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  # Get the current user from the session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Check if a user is logged in
  def logged_in?
    current_user.present?
  end

  # Require login for certain actions
  def require_login
    redirect_to new_session_path, alert: "ログインしてください" unless logged_in?
  end
end
