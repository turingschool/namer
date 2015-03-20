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
    if user = User.find_by(github_id: auth.uid)
      session[:user_id] = user.id
      redirect_to subdomains_path
    else
      user = User.new(email: auth.info.email,
                         github_token: auth.credentials.token,
                         github_account: auth.info.nickname,
                         github_id: auth.uid)
      if user.save
        session[:user_id] = user.id
        redirect_to subdomains_path
      else
        raise "balls :("
      end
    end
  end
end
