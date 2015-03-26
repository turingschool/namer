class AppsController < ApplicationController
  def index
    @apps = Subdomain.all
  end
end
