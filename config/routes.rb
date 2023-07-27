Rails.application.routes.draw do

  namespace :admin do
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
  end
  namespace :public do
    get 'deliveries/index'
    get 'deliveries/edit'
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

    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]

    resources :deliveries, only: [:create, :update, :destroy, :edit, :index]
  end

  get 'admin' => 'admin/homes#top',as: "admin_top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
