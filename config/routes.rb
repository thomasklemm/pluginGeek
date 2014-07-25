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

  # Platform categories
  get '/', to: 'categories#index', as: :global_platform

  get '/:platform_id', to: 'categories#index', as: :platform,
    constraints: { platform_id: PLATFORM_IDS_REGEXP }

  # Categories
  resources :categories, except: :index do
    get :autocomplete, on: :collection
  end

  # Repos
  resources :repos, except: :index,
    constraints: { id: REPO_OWNER_AND_NAME_REGEXP }

  # Links
  resources :links, except: :show

  # Services
  resources :services

  # Submissions
  get 'submit' => 'submissions#submit', as: :submit

  # Static pages
  get ':id', to: 'high_voltage/pages#show', as: :static

  # Root route
  root to: 'categories#index'
end
