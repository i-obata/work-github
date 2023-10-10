class Public::CustomersController < ApplicationController
    
    # =================================================================================
    # 顧客のマイページ画面（GETアクション）
    # =================================================================================
    def show
        @customer = current_customer
    end
    
    # =================================================================================
    # 顧客の登録情報編集画面（GETアクション）
    # =================================================================================
    def edit
        @customer = current_customer
    end
    
    # =================================================================================
    # 顧客の登録情報更新処理（PATCHアクション）
    # =================================================================================
    def update
        customer = current_customer
        if customer.update(customer_params)
        flash[:notice] = "successfully edited the customer!"
            redirect_to customers_path
        else
            render :edit
        end
    end
    
    # =================================================================================
    # 顧客の退会確認画面（GETアクション）
    # ※インスタンス変数の値は表示しないためcontrollerでの処理はなし
    # =================================================================================
    def confirm_withdraw
    end
    
    # =================================================================================
    # 顧客の退会処理（PATCHアクション）
    # 退会ステータスを更新
    # =================================================================================
    def withdraw
        customer = current_customer
        customer.update(is_deleted: true)
        reset_session
        redirect_to root_path
    end
    
    private
    
    # =================================================================================
    # customerの更新可能項目
    # 姓、名、姓カナ、名カナ、メールアドレス、郵便番号、住所、電話番号が更新可能
    # =================================================================================
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
    end
end
