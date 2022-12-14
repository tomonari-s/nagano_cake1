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
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    root "homes#top"
    post 'genres/create'
    patch 'items/:id' => 'items#update', as: 'update_item'
  end
  
  scope module:  :public, shallow: true do
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    get '/orders/complete' => 'orders#complete', as: 'complete'
    post '/orders/comfirm' => 'orders#comfirm', as: 'comfirm'
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    get "/customers/my_page" => "customers#show"
    get "/customers/information/edit" => "customers#edit"
    patch "/customers/information" => "customers#update"
    resources :items, only: [:index, :show]
    resources :homes, only: [:top, :about]
    root to: 'homes#top'
    get "/about" => "homes#about", as: "about"
    # 退会確認画面
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
