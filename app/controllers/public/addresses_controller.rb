class Public::AddressesController < ApplicationController
    
    # =================================================================================
    # 顧客の配送先情報の新規登録処理（POSTアクション）
    # =================================================================================
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        if @address.save
            flash[:notice] = "successfully submitted the book!"
        end
        @addresses = Address.all 
        @address = Address.new
        render :index
    end

    # =================================================================================
    # 顧客の配送先一覧画面（GETアクション）
    # =================================================================================
    def index
        @addresses = Address.all
        @address = Address.new
    end

    # =================================================================================
    # 顧客の配送先編集画面（GETアクション）
    # =================================================================================
    def edit
        @address = Address.find(params[:id])
    end
    
    # =================================================================================
    # 顧客の配送先情報更新処理（PATCHアクション）
    # =================================================================================
    def update
        address = Address.find(params[:id])
        if address.update(address_params)
        flash[:notice] = "successfully edited the address!"
            redirect_to addresses_path
        else
            render :edit
        end
    end

    # =================================================================================
    # 顧客の配送先情報削除処理（DELETEアクション）
    # =================================================================================
    def destroy
        address =Address.find(params[:id])
        if address.destroy
            flash[:notice] = "The address was successfully destroyed."
        end
        @addresses = Address.all
        @address = Address.new
        render :index
    end
    
    private

    # =================================================================================
    # addressの更新可能項目
    # 顧客ID、郵便番号、住所、宛先が更新可能
    # =================================================================================
    def address_params
        params.require(:address).permit(:customer_id, :postal_code, :address, :destination)
    end
end
