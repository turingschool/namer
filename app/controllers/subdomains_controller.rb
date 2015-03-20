class SubdomainsController < ApplicationController
  before_filter :require_login
  def index
  end

  def new
    @subdomain = current_user.subdomains.new
  end

  def create
    @subdomain = current_user.subdomains.new(subdomain_params)
    if @subdomain.valid? && @subdomain.register!
      flash[:message] = "Congrats, you registered the subdomain #{@subdomain.subdomain}.turingapps.io to point to #{@subdomain.content}"
      redirect_to user_subdomains_path(current_user)
    else
      render :new
    end
  end

  private

  def subdomain_params
    params.require(:subdomain).permit(:content, :subdomain)
  end
end
