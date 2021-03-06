Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'auths' }
  #root path
  root 'books#index'

  #routes app
  resources :books, only: [:index, :show]
  resources :order_items, only: [:index, :update, :destroy]
  resources :orders, only: [:index, :create ]
  resources :order_steps, only: [:show, :update ]
  resources :wish_lists, only: [:index, :destroy]
  resources :ratings, only: [:create]

  namespace :admin do
    resources :categories, except: :show
    resources :authors, except: :show
    resources :books, except: [:show]
    resources :ratings, only: [:index, :update, :destroy]
    resources :orders, only: [:index, :update]
  end

  get '/add_to_cart', to: 'books#add_to_cart'
  get '/add_to_wish_list', to: 'books#add_to_wish_list'
  get '/coupon', to: 'orders#coupon'
  get '/manager', to: redirect('admin/books')


  #match '/signup',  to: 'users#new',            via: 'get'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  #   concerns :toggleable do
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
