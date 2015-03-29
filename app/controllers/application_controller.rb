class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil unless session[:current_user]
    @current_user ||= User.new(session[:current_user])
  end
  helper_method :current_user

  def require_login
    redirect_to login_path unless current_user
  end
end
