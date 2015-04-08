class ApplicationController < ActionController::Base
  include TuringAuth::CurrentUser
  protect_from_forgery with: :exception

  def require_login
    redirect_to login_path unless current_user
  end
end
