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

  # Submissions
  get 'submit' => 'submissions#submit', as: :submit

  # Links
  resources :links, except: :show

  # Categories
  resources :categories, only: [:show, :edit, :update, :destroy]

  get ':language' => 'categories#index', as: :categories,
    constraints: { language: /#{ Language::All.join('|') }/i }

  # language shortcut redirection
  get 'js' => redirect('/javascript')

  # Repos
  #   Note: Routes for generating url differ from routes reading url, some duplication here
  #   Cause: FriendlyId uses /repos/:id to generate route when using link_to
  #     while matching incoming requests is being done through seperate routes
  #     (as friendly_id contains slashes)
  resources :repos, only: [:show, :new, :create, :edit] do
    collection do
      constraints name: %r{[^\/]+(?=\.html\z)|[^\/]+} do
        get    ':owner/:name'      => 'repos#show'
        get    ':owner/:name/edit' => 'repos#edit'
        put    ':owner/:name'      => 'repos#update'
        delete ':owner/:name'      => 'repos#destroy'
      end
    end
  end

  # Authorize Blitz.io load testing
  get 'mu-a4ca81c6-8526fed8-0bc25966-0b2cc605' => 'application#authorize_load_testing'

  # Root
  root to: 'categories#index'

  # Error pages
  get ':id', to: 'pages#show', as: :static

  # HighVoltage adds the page_path(:id) route
  # page     GET    /pages/*id    high_voltage/pages#show
end
