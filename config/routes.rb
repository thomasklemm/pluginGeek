Plugingeek::Application.routes.draw do
  # User authentication
  devise_for :users,
    path_names: {sign_in: 'login', sign_out: 'logout'},
    controllers: {omniauth_callbacks: 'omniauth'}

  devise_scope :user do
    get 'login',     to: 'devise/sessions#new',     as: :new_user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  # Shorthand named login and logout paths
  get 'login', to: 'devise/sessions#new', as: :login
  delete 'logout', to: 'devise/sessions#destroy', as: :logout

  # Categories
  resources :categories, only: [:show, :edit, :update, :destroy] do
    post 'refresh', on: :member
  end

  get ':language' => 'categories#index', as: :categories,
    constraints: { language: /#{ Language::All.join('|') }/i }

  # Language shortcut redirection
  get 'js' => redirect('/javascript')

  # Repos
  # split into routes for generating urls and matching requests
  # to allow for ':owner/:name' path segments.

  # Routes for matching the incoming requests and routing them
  scope :repos, path: 'repos' do
    constraints(owner: /[^\/]+/, name: /[^\/]+/) do
      get ':owner/:name'            => 'repos#show'
      get ':owner/:name/edit'       => 'repos#edit'
      patch  ':owner/:name'         => 'repos#update'
      delete ':owner/:name'         => 'repos#destroy'
      post   ':owner/:name/refresh' => 'repos#refresh'
    end
  end

  # Routes for generating urls with friendly_id
  # plus new and create paths on repos resource
  resources :repos, only: [:show, :new, :create, :edit] do
    put 'refresh', on: :member
  end

  # Services
  resources :services

  # Links
  resources :links, except: :show

  # Submissions
  get 'submit' => 'submissions#submit', as: :submit

  # Dynamic robots.txt
  get 'robots.:format' => 'robots#index'

  # Authorize blitz.io load testing
  get 'mu-a4ca81c6-8526fed8-0bc25966-0b2cc605' => 'application#authorize_blitz_io' # standalone
  get 'mu-943299b6-11bc48bc-a8df1760-5139a504' => 'application#authorize_blitz_io' # blitz.io heroku addon

  # Authorize loader.io load testing
  get 'loaderio-ca7d285a7cea4be8e79cecd78013aee6' => 'application#authorize_loader_io' # loader.io heroku addon

  # Peek
  mount Peek::Railtie => '/peek'

  # Static pages
  get ':id', to: 'high_voltage/pages#show', as: :static

  # Root
  root to: 'categories#index'
end
