class Admin::OrdersController < ApplicationController
    
    before_action :authenticate_admin!
    
    # =================================================================================
    # 注文詳細画面（GETアクション）
    # =================================================================================
    def show
        @order = Order.find(params[:id])
        @order_items = @order.order_items
    end
    
    # =================================================================================
    # 注文ステータス更新（PATCHアクション）
    # =================================================================================
    def update
        order = Order.find(params[:id])
        order.update(order_params)

        # 注文ステータスが"入金確認"になった場合
        if order.status == "payment_confirmation"
            
            # 作成ステータスをすべて"製作待ち"に変更する
            order.order_items.each do |order_item|
                order_item.update(produce_status: :awaiting_manufacture)
            end
            
        # 注文ステータスが"発送準備中"or"発送済み"になった場合
        elsif order.status == "preparing_ship" || order.status == "shipped"
            
            # 作成ステータスがすべて"製作完了"でない場合、"製作中"に変更する
            order.order_items.each do |order_item|
                if order_item.produce_status != "complete"
                    order.update(status: :under_manufacture)
                    break
                end
            end
        end
        
        redirect_to admin_order_path(order.id)
    end
    
    private
    
    # =================================================================================
    # orderの更新可能項目
    # 注文ステータスが更新可能
    # =================================================================================
    def order_params
        params.require(:order).permit(:status, order_items_attributes: [:produce_status])
    end
end
