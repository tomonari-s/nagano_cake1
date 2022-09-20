Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  
  namespace :admin do
    resources :order_orders, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    root "homes#top"
    post 'genres/create'
  end
  
  namespace :public do
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:comfirm, :complete, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :items, only: [:index, :show]
    resources :homes, only: [:top, :about]
    root to: 'homes#top'
    get "home/about" => "homes#about", as: "about"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
