Knight::Application.routes.draw do
  # Oauth
  get 'login'   => 'sessions#login',   as: :login
  get 'logout'  => 'sessions#destroy', as: :logout

  match 'oauth/callback'  => 'oauths#callback'
  match 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider

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
  resources :repos, only: [:show, :edit] do
    collection do
      constraints name: /[^\/]+(?=\.html\z)|[^\/]+/ do
        get ':owner/:name/edit'        => 'repos#edit'
        get ':owner/:name(/*remains)'  => 'repos#show'
        post ':owner/:name'            => 'repos#create'
        put ':owner/:name'             => 'repos#update'
      end
    end
  end

  # Sidekiq Web Interface
  # TODO: Authentication
  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'admin/sidekiq', as: :sidekiq

  # Blitz.io Authentication
  get 'mu-a4ca81c6-8526fed8-0bc25966-0b2cc605' => 'application#blitz'

  # Remove unknown subdomains on root
  constraints(SubdomainPresence) do
    get '' =>  'application#remove_subdomain'
  end

  # Static Pages
  get ':id' => 'high_voltage/pages#show', as: :static

  # Root
  root to: 'categories#index'
end
