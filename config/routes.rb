Rails.application.routes.draw do

  # 顧客用（public）  
  scope module: :public do
    
    #homesコントローラー 
    root to: "homes#top"
    get "/about" => "homes#about"
    
    # itemsコントローラー
    resources :items, only:[:index, :show]
    
    # customersコントローラー
    resource :customers, only:[:show, :edit, :update]
    get "customers/confirm_withdraw" => "public/customers#confirm_withdraw"
    patch "customers/withdraw"
    
    # addressesコントローラー
    resources :addresses, only:[:create, :index, :edit, :update, :destroy]
    
    # cart_itemsコントローラー
    resources :cart_items, only:[:create, :index, :update, :destroy]
    delete :cart_items, to: "cart_items#destroy_all"
    
    # ordersコントローラー
    resources :orders, only:[:new, :create, :index, :show]
    get "orders/confirm" => "public/orders#confirm"
    get "orders/complete" => "public/orders#complete"
  
    #devise（registrationsコントローラー、sessionsコントローラー）
    devise_for :customers, skip: [:passwords],controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    
  end
   
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  get "/admin" => "admin/homes#top", as: "admin"
  namespace :admin do
    
    # homesコントローラー
    root to: "homes#top"
    
    # itemsコントローラー
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
    
    # customersコントローラー
    resources :customers, only:[:index, :show, :edit, :update]
    
    # ordersコントローラー
    resources :orders, only:[:show, :update]
    
    # order_itemsコントローラー
    resources :order_items, only:[:update]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
