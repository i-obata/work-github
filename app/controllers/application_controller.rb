class ApplicationController < ActionController::Base
    
    # before_action :configure_permitted_parameters, if: :devise_controller?
    
    # =================================================================================
    # サインイン後の遷移先
    # =================================================================================
    def after_sign_in_path_for(resource)
        
        if admin_signed_in?
            admin_root_path
        elsif customer_signed_in?
            customers_path
        end
    end
    
    # =================================================================================
    # サインアウト後の遷移先
    # =================================================================================
    def after_sign_out_path_for(resource)
        
        if resource == :admin
            new_admin_session_path
        elsif resource == :customer
            root_path
        end
         
    end
    
    # =================================================================================
    # 顧客画面の認証
    # =================================================================================
    def authenticate_customer
        unless current_user.customer?
            redirect_to new_customer_session_path
        end
    end
    
    # =================================================================================
    # 管理者画面の認証
    # =================================================================================
    def authenticate_admin
        unless current_user.admin?
            redirect_to new_admin_session_path
        end
    end
    
    
    # 以下ストロングパラメータ
    protected
    
    # ユーザー登録の際にパラメータの操作を許可
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :encrypted_password, :postal_code, :address, :telephone_number])
    end
end
