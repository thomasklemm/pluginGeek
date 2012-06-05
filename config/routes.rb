Knight::Application.routes.draw do


  # Show routes generates friendly_id route
  resources :repos, only: [:index, :show] do

    # Owner Routes
    # get ':owner' => 'users#show', on: :collection
    # get ':owner/new' => 'users#new', on: :collection
    # get ':owner/create' => 'users#create', on: :collection
    # post ':owner/create' => 'users#create', on: :collection

    # Repo Routes
    get ':owner/:name/create' => 'repos#create', on: :collection, :constraints => { :name => /[^\/]+(?=\.html\z)|[^\/]+/ }
    get ':owner/:name(/*leftover)' => 'repos#show', on: :collection, :constraints => { :name => /[^\/]+(?=\.html\z)|[^\/]+/ }
    put ':owner/:name' => 'repos#update', on: :collection, :constraints => { :name => /[^\/]+(?=\.html\z)|[^\/]+/ }
    delete ':owner/:name' => 'repos#destroy', on: :collection, :constraints => { :name => /[^\/]+(?=\.html\z)|[^\/]+/ }

  end

  resources :categories, only: [:index, :show, :update]

  # TODO: only allow repos resources routes that matter.

  # For when to implement json response for repos#show
  # Constraints: name can be anything but cannot end on .html (and .json):constraints => { :name => /[^\/]+(?=\.html\z|\.json\z)|[^\/]+/ }

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: "categories#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
