Rails.application.routes.draw do
  root to: "apps#index"
  get "/auth/:provider/callback" => "sessions#create"
  get '/login' => 'sessions#new', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  resources :apps, only: [:index]


  resources :subdomains
end
