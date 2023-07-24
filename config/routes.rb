Rails.application.routes.draw do

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
    resources :items
    resources :customers
    resources :cart_items
  end

  get 'admin' => 'admin/homes#top',as: "admin_top"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
