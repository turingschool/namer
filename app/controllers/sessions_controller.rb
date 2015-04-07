class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to subdomains_path
    else
      redirect_to '/auth/github'
    end
  end

  def create
    puts "Sessions#create!"
    auth = request.env["omniauth.auth"]
    if auth && turing_member?
      user_info = {github_id: auth.uid, github_token: auth.credentials.token,
                   github_name: auth.info.nickname, email: auth.info.email}
      Rails.logger.info("user is turing member, will log them in with info: #{user_info}")
      @current_user = User.new(user_info)
      session[:current_user] = @current_user.as_json
      redirect_to subdomains_path
    else
      Rails.logger.error("user is not authed or is not turing member...redirect them")
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

  private

  def octokit
    if request.env["omniauth.auth"] && request.env["omniauth.auth"].credentials.token
      Rails.logger.error("got user creds; will make omniauth request with token #{request.env["omniauth.auth"].credentials.token}")
      Octokit::Client.new(:access_token => request.env["omniauth.auth"].credentials.token)
    else
      Rails.logger.error("no user credentials available; making non-authed omniauth client")
      Octokit::Client.new #won't have access to user-specific stuff
    end
  end

  def user_gh_teams
    begin
      teams = octokit.user_teams.map(&:id)
      Rails.logger.info("found user teams for user #{teams}")
      teams
    rescue Octokit::NotFound
      Rails.logger.error("Octokit failed retrieving User GH Teams")
      []
    end
  end

  def turing_member?
    (user_gh_teams & TURING_GH_TEAMS).any?
  end
end
