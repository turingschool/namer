class ApplicationController < ActionController::Base
  include TuringAuth::CurrentUser
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    redirect_to login_path unless current_user
  end
end
