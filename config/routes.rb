Rails.application.routes.draw do

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about', as: "about"

   devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    get '/customers/show' => 'customers#show', as: "customer"
    get '/customers/information/edit' => 'customers#edit', as: "edit_customer"
    patch '/customers/update' => 'customers#update', as: "update_customer"
    get '/customers/confirm' => 'customers#confirm', as: "confirm_customer"
    patch '/customers/withdraw' => 'customers#withdraw', as: "withdraw_customer"

    resources :items, only: [:index, :show]

    get '/cart_items' => 'cart_items#index', as: "cart_items"
    patch '/cart_items/:id' => 'cart_items#update', as: "cart_item_update"
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: "cart_items_destroy_all"
    delete '/cart_items/:id' => 'cart_items#destroy', as: "cart_items_destroy"

    post '/cart_items/' => 'cart_items#create', as: "cart_items_create"

    get 'deliveries/index'
    get 'deliveries/edit'

    get	'/orders/new' => 'orders#new'
    post '/orders/confirm' => 'orders#confirm', as: "confirm_orders"
    get '/orders/complete' => 'orders#complete', as: "complete_orders"
    post '/orders' => 'orders#create', as: "create_orders"
    get '/orders' => 'orders#index', as: "orders"
    get '/orders/:id' => 'orders#show', as: "order"

  end

  get 'admin' => 'admin/homes#top',as: "admin_top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
