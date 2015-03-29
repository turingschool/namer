class SubdomainsController < ApplicationController
  before_filter :require_login
  before_filter :load_subdomain, only: [:destroy, :show, :edit, :update]
  before_filter :require_owner, only: [:destroy, :edit, :update]
  def index
  end

  def new
    @subdomain = current_user.subdomains.new
  end

  def create
    @subdomain = Subdomain.new(subdomain_params)
    if @subdomain.register!
      #TODO: need to add step to tell user to configure their heroku stuff
      flash[:message] = "Congrats, you registered the subdomain #{@subdomain.subdomain}.turingapps.io to point to #{@subdomain.content}"
      redirect_to subdomains_path
    else
      flash[:error] = "sorry, there was an issue registering your subdomain"
      render :new
    end
  end

  def destroy
    if @subdomain.deregister!
      flash[:success] = "Unregistered subdomain #{@subdomain.subdomain}.turingapps.io"
    else
      flash[:error] = "Whoops, we couldn't de-register that subdomain."
    end
    redirect_to subdomains_path
  end

  private

  def require_owner
    unless current_user && @subdomain.user_github_id == current_user.github_id
      flash[:error] = "You can't do that..."
      redirect_to subdomains_path
    end
  end

  def load_subdomain
    @subdomain = Subdomain.find(params[:id])
  end

  def subdomain_params
    params.require(:subdomain).permit(:content, :subdomain).merge(user_github_id: current_user.github_id)
  end
end
