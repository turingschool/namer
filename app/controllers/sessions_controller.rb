class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_subdomains_path(current_user)
    else
      redirect_to '/auth/github'
    end
  end

  #TODO: require user is member of turing org
  def create
    auth = request.env["omniauth.auth"]
    if user = User.find_by(github_id: auth.uid)
      session[:user_id] = user.id
      redirect_to user_subdomains_path(current_user)
    else
      user = User.new(email: auth.info.email,
                         github_token: auth.credentials.token,
                         github_account: auth.info.nickname,
                         github_id: auth.uid)
      if user.save
        session[:user_id] = user.id
        redirect_to user_subdomains_path(current_user)
      else
        raise "balls :("
      end
    end
  end
end
