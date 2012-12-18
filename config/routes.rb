Knight::Application.routes.draw do
  ##
  # Oauth
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#login', as: :login
  match 'oauth/callback'  => 'oauths#callback'
  match 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider

  get 'debug' => 'users#debug'

  ##
  # Categories
  resources :categories, only: [:show, :edit, :update]

  get ':language' => 'categories#index',
    as: :categories,
    constraints: { language: /#{ Language::All.join('|') }/i }

  # language shortcut redirection
  get 'js' => redirect('/javascript')

  # language subdomain redirection
  constraints(Subdomain) do
    get '/' => 'application#redirect_subdomain'
  end

  ##
  # Repos
  #   Note: Routes for generating url differ from routes reading url, some duplication here
  #   Cause: FriendlyId uses /repos/:id to generate route when using link_to
  #     while matching incoming requests is being done through seperate routes
  #     (as friendly_id contains slashes)
  resources :repos, only: [:index, :show, :edit] do
    collection do
      # Repo Routes
      constraints name: /[^\/]+(?=\.html\z)|[^\/]+/ do
        get ':owner/:name/edit'         => 'repos#edit'
        get ':owner/:name(/*leftover)'  => 'repos#show'
        post ':owner/:name'             => 'repos#create'
        put ':owner/:name'              => 'repos#update'
      end
    end
  end

  # Blitz.io Authentication
  get 'mu-a4ca81c6-8526fed8-0bc25966-0b2cc605' => 'application#blitz'

  # Admin View
  get 'admin' => 'admin#index', as: :admin

  # Sidekiq Web Interface
  # TODO: HTTP Basic Authentication
  require 'sidekiq/web'
  admin_constraint = lambda { (http_basic_authenticate_with name: 'kshkjhe', password: 'tesfkfjksst') }
  constraints admin_constraint do
    mount Sidekiq::Web, at: 'admin/sidekiq', as: :sidekiq
  end

  # Static Pages
  match ':id' => 'high_voltage/pages#show', as: :static, via: :get

  # Remove unknown subdomains on root
  constraints(SubdomainPresence) do
    get '' =>  'application#remove_subdomain'
  end

  # Root
  root to: 'categories#index'
end
