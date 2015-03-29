class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_subdomains_path(current_user)
    else
      redirect_to '/auth/github'
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth && turing_member?
      @current_user = User.new(github_id: auth.uid, github_token: auth.credentials.token,
                               github_name: auth.info.nickname, email: auth.info.email)
      session[:current_user] = @current_user.as_json
      redirect_to user_subdomains_path(user_id: current_user.github_id)
    else
      flash[:error] = "Sorry, only members of the Turing github organization can do that."
      redirect_to root_path
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end

  private

  def octokit
    if request.env["omniauth.auth"] && request.env["omniauth.auth"].credentials.token
      Octokit::Client.new(:access_token => request.env["omniauth.auth"].credentials.token)
    else
      Octokit::Client.new #won't have access to user-specific stuff
    end
  end

  def user_gh_teams
    begin
      octokit.user_teams.map(&:id)
    rescue Octokit::NotFound
      []
    end
  end

  def turing_member?
    (user_gh_teams & TURING_GH_TEAMS).any?
  end
end
