class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    # サインイン後の遷移先
    def after_sign_in_path_for(resource)
        customers_path
    end
    
    # サインアウト後の遷移先
    def after_sign_out_path_for(resource)
        homes_about_path
    end
    
    # 以下ストロングパラメータ
    protected
    
    # ユーザー登録の際にパラメータの操作を許可
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
    end
end
