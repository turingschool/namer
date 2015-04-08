TuringAuth.client_id = ENV['NAMER_GITHUB_ID']
TuringAuth.client_secret = ENV['NAMER_GITHUB_SECRET']
TuringAuth.init! #init omniauth extensions

#monkeypatches to add app-specific logic to turingauth user class
require "turing_auth/user"
module TuringAuth
  class User
    def subdomains
      Subdomain.where(user_github_id: github_id)
    end
  end
end
