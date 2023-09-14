class Public::OrdersController < ApplicationController
    
    # =================================================================================
    # 注文確認画面(GETアクション)
    # =================================================================================
    def new
        @order = Order.new
    end
    
    # =================================================================================
    # 注文情報確認画面（GETアクション）
    # =================================================================================
    def confirm
        
        @cart_item = Cart_Item.where(customer_id: current_customer.id)
        @totalprice = 0
        # 新しく住所入力した情報も含めて取得
        @order = Order.new(order_params)
        
        if params[:order][:select_address] == "0"
        
            # 自身の住所を取得
            @order.postal_code = current_customer.postal_code
            @order.address = surrent_customer.address
            @order.name =current.customer.first_name + current_customer.last_name
        
        elsif params[:order][:select_address] == "1"
            
            # 登録された住所から選択
            @address = Address.find(params[:order][:address_id])
            @order.postal = @address.postal_code
            @order.address = @address.address
            @order.name = @address.name
            
        end
    end

    # =================================================================================
    # 注文完了画面（GETアクション）
    # =================================================================================
    def complete
    end
    
    # =================================================================================
    # 注文確定処理（POSTアクション）
    # =================================================================================
    def create
        order = Order.new(order_params)
        
        # 郵便番号、住所、宛先の格納
        if params[:order][:select_address] == "0"
        
            # 自身の住所を取得
            order.postal_code = current_customer.postal_code
            order.address = surrent_customer.address
            order.name =current.customer.first_name + current_customer.last_name
        
        elsif params[:order][:select_address] == "1"
            
            # 登録された住所から選択
            address = Address.find(params[:order][:address_id])
            order.postal = address.postal_code
            order.address = address.address
            order.name = address.name
            
        end
    end
    
    # =================================================================================
    # 注文履歴画面（GETアクション）
    # =================================================================================
    def index
    end

    # =================================================================================
    # 注文履歴詳細（GETアクション）
    # =================================================================================
    def show
    end
    
    private
    
    # =================================================================================
    # orderのデータ入力
    # =================================================================================
    def order_params
        params.require(:order).permit(:payment, :postal_code, :address, :destination)
    end
end
