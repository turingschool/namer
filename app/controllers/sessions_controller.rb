class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to subdomains_path
    else
      redirect_to '/auth/github'
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    user_info = {github_id: auth.uid, github_token: auth.credentials.token,
                 github_name: auth.info.nickname, email: auth.info.email}
    user = TuringAuth::User.new(user_info)
    if user.valid? && user.turing_member?
      @current_user = user
      session[:current_user] = @current_user.as_json
      redirect_to subdomains_path
    else
      flash[:error] = "Sorry, only members of the Turing github organization can do that."
      redirect_to root_path
    end
  end

  def failure
    Rails.logger.error("Oauth failed...#{params[:message]}")
    flash[:notice] = params[:message]
    redirect_to root_path
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end
end
