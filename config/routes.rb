Rails.application.routes.draw do
  root to: "sessions#new"
  get "/auth/:provider/callback" => "sessions#create"
  get '/login' => 'sessions#new', :as => :signin
  get '/logout' => 'sessions#destroy', :as => :signout
end
