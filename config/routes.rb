Rails.application.routes.draw do
  post "/channel" => 'channels#create'

  get 'admins/settings'

  resources :videos do
    collection do
      get 'search'
    end
    member do
      post 'like_dislike'
    end
    resources :comments
  end

  get '/settings' => 'admins#settings'
  post 'admins/add_category' => "admins#add_category"
  post '/save_draft' => 'videos#save_draft'

  resources :blogs do
    collection do
      get 'search'
    end
    resources :comments
  end

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root "dashboards#home"
  get '/home' => "dashboards#home"
  devise_scope :user do
    get '/sign_out' => "devise/sessions#destroy"
  end

  resources :comments do
    resources :comments
  end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
