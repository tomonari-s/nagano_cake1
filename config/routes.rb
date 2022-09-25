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
    patch 'items/:id' => 'items#update', as: 'update_item'
  end
  
  namespace :public do
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:comfirm, :complete, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
    resources :homes, only: [:top, :about]
    root to: 'homes#top'
    get "/about" => "homes#about", as: "about"
    # 退会確認画面
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
