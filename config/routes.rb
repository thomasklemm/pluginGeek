Plugingeek::Application.routes.draw do
  get "services/index"

  get "services/show"

  get "services/new"

  get "services/create"

  get "services/edit"

  get "services/update"

  get "services/destroy"

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

  # Submissions
  get 'submit' => 'submissions#submit', as: :submit

  # Links
  resources :links, except: :show

  # Categories
  resources :categories, only: [:show, :edit, :update, :destroy] do
    put 'refresh', on: :member
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
      get ':owner/:name' => 'repos#show'
      get ':owner/:name/edit' => 'repos#edit'
      put ':owner/:name' => 'repos#update'
      delete ':owner/:name' => 'repos#destroy'
      put ':owner/:name/refresh' => 'repos#refresh'
    end
  end

  # Routes for generating urls with friendly_id
  # plus new and create paths on repos resource
  resources :repos, only: [:show, :new, :create, :edit] do
    put 'refresh', on: :member
  end

  # Authorize Blitz.io load testing
  get 'mu-a4ca81c6-8526fed8-0bc25966-0b2cc605' => 'application#authorize_load_testing'

  # Static pages
  get ':id', to: 'high_voltage/pages#show', as: :static

  # Root
  root to: 'categories#index'
end
