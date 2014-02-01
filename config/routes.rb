Plugingeek::Application.routes.draw do
  # User authentication
  devise_for :users,
    path_names: {sign_in: 'login', sign_out: 'logout'},
    controllers: {omniauth_callbacks: 'omniauth'}

  devise_scope :user do
    get 'login',     to: 'devise/sessions#new',     as: :new_user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  # Shorthands
  get 'login', to: 'devise/sessions#new', as: :login
  delete 'logout', to: 'devise/sessions#destroy', as: :logout

  # Languages
  resources :languages, only: :show

  # Categories
  resources :categories, only: [:show, :edit, :update, :destroy] do
    post :refresh, on: :member
  end

  # Repos
  # split into routes for generating urls and matching requests
  # to allow for ':owner/:name' path segments
  #
  # Match incoming requests
  namespace :repos do
    # Allow for .js and more in repo names
    constraints(owner: /[^\/]+/, name: /[^\/]+/) do
      get ':owner/:name'            => 'repos#show'
      get ':owner/:name/edit'       => 'repos#edit'
      patch  ':owner/:name'         => 'repos#update'
      delete ':owner/:name'         => 'repos#destroy'
      post   ':owner/:name/refresh' => 'repos#refresh'
    end
  end

  # Generate repo paths
  resources :repos, only: [:show, :new, :create, :edit]

  # Links
  resources :links, except: :show

  # Services
  resources :services

  # Submissions
  get 'submit' => 'submissions#submit', as: :submit

  # Dynamic robots.txt
  get 'robots.:format' => 'robots#index'

  # Authorize blitz.io load testing
  get 'mu-a4ca81c6-8526fed8-0bc25966-0b2cc605' => 'application#authorize_blitz_io' # standalone
  get 'mu-943299b6-11bc48bc-a8df1760-5139a504' => 'application#authorize_blitz_io' # blitz.io heroku addon

  # Authorize loader.io load testing
  get 'loaderio-ca7d285a7cea4be8e79cecd78013aee6' => 'application#authorize_loader_io' # loader.io heroku addon

  # Static pages
  get ':id', to: 'high_voltage/pages#show', as: :static

  root 'languages#index'
end
