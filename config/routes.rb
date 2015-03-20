Rails.application.routes.draw do
  root to: "sessions#new"
  get "/auth/:provider/callback" => "sessions#create"
  get '/login' => 'sessions#new', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout


  resources :users, only: [] do
    resources :subdomains
  end
end
