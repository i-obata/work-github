class Admin::CustomersController < ApplicationController
    
    # =================================================================================
    # 顧客一覧画面（GETアクション）
    # =================================================================================
    def index
        @customers = Customer.page(params[:page])
    end
    
    # =================================================================================
    # 顧客詳細画面（GETアクション）
    # =================================================================================
    def show
        @customer = Customer.find(params[:id])
    end
    
    # =================================================================================
    # 顧客編集画面（GETアクション）
    # =================================================================================
    def edit
        @customer = Customer.find(params[:id])
    end
    
    # =================================================================================
    # 顧客情報の更新処理（PATCHアクション）
    # =================================================================================
    def update
        customer = Customer.find(params[:id])
        if customer.update(customer_params)
        flash[:notice] = "successfully edited the user!"
            redirect_to admin_customer_path(customer.id)
        else
            render :edit
        end
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
