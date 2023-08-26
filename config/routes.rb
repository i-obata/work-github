Rails.application.routes.draw do

  # 顧客用（public）  
  scope module: :public do
    
    #homesコントローラー 
    # root to: "homes#top"
    get "homes/about" => "public/homes#about"

    #devise（registrationsコントローラー、sessionsコントローラー）
    devise_for :customers, skip: [:passwords],controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    
    # customersコントローラー
    resource :customers, only:[:show, :edit, :update]
    get "customers/confirm_withdraw" => "customer#confirm_withdraw"
    patch "customers/withdraw"
  end
   
  
  
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
