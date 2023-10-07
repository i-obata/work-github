# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  # 顧客アカウントが既に退会しているか確認
  def customer_state
    
    # emailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    
    # アカウントが取得できなかった場合、メソッド終了
    return if !@customer
    
    # パスワードと退会ステータス判定
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
      redirect_to new_customer_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
