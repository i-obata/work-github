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
        
        @cart_item = CartItem.where(customer_id: current_customer.id)
        @totalprice = 0
        # 新しく住所入力した情報も含めて取得
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        
        if params[:order][:select_address] == "select_address_1"
        
            # 自身の住所を取得
            @order.postal_code = current_customer.postal_code
            @order.address = current_customer.address
            @order.destination =current_customer.last_name + current_customer.first_name
        
        elsif params[:order][:select_address] == "select_address_2"
            
            # 登録された住所から選択
            @address = Address.find(params[:order][:address_id])
            @order.postal_code = @address.postal_code
            @order.address = @address.address
            @order.destination = @address.destination
            
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
        cart_items = CartItem.where(customer_id: current_customer.id)
        
        order.save
        
        # order_itemの生成
        cart_items.each do |cart_item|
            order_item = OrderItem.new
            order_item.item_id = cart_item.item.id
            order_item.order_id = order.id
            order_item.amount = cart_item.amount
            order_item.price_including_tax = cart_item.item.with_tax_price
            order_item.save
        end
        
        # cart_itemsを削除
        cart_items.destroy_all
        
        redirect_to orders_complete_path
    end
    
    # =================================================================================
    # 注文履歴画面（GETアクション）
    # =================================================================================
    def index
        @order = Order.where(customer_id: current_customer.id).order(created_at: :desc)
    end

    # =================================================================================
    # 注文履歴詳細（GETアクション）
    # =================================================================================
    def show
        @order = Order.find(params[:id])
    end
    
    private
    
    # =================================================================================
    # orderのデータ入力
    # =================================================================================
    def order_params
        params.require(:order).permit(:customer_id, :payment, :postal_code, :address, :destination, :total_cost, :postage, :status)
    end
end
