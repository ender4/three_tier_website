ThreeTierWebsite::Application.routes.draw do
  
  resources :pages #do
    #resources :categories do
    #  resources :items
    #end
  #end
  resources :users, :only => [:show]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :photos#, :only => [:show, :index]
  
  #match "/users/:id" => "users#show", :as => :show_user
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/photos/:photo_name', :to => 'photos#show', :as => :show_photo
  match "/:page_name" => "pages#show", :as => :show_page
  match "/:page_name/:category_name" => "pages#show", :as => :show_category
  match "/:page_name/:category_name/:item_name" => "pages#show",
      :as => :show_item
  
  root :to => "pages#show", :page_id => 1
  
  # get "photos/new"
  # get "photos/edit"
  # get "photos/create"
  # get "photos/update"
  # get "photos/destroy"
  # get "sessions/new"
  # get "users/show"
  # get "pages/show"
  # get "pages/new"
  # get "pages/create"
  # get "pages/edit"
  # get "pages/update"
  # get "pages/destroy"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
