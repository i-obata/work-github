class Admin::OrderItemsController < ApplicationController
    
    before_action :authenticate_admin!
    
    # =================================================================================
    # 製造ステータス更新（PATCHアクション）
    # =================================================================================
    def update
        order_item = OrderItem.find(params[:id])
        order_item.update(order_item_params)
        
        order_items = OrderItem.where(order_id: order_item.order_id)
        order = Order.where(id: order_item.order_id)
        
        # 製造ステータスが"製造中"or"製造完了"の場合
        order_items.each do |order_item|
            
            # 注文ステータスを"製造中"に変更
            if order_item.produce_status == "under_manufacture" || order_item.produce_status == "complete"
                order.update(status: :under_manufacture)
                break
            end
        end
        
        # すべての製造ステータスが"製造完了"の場合
        if order_items.where(produce_status: :complete).count == order_items.count
            
            # 注文ステータスを"発送準備中"に更新
            order.update(status: :preparing_ship)
            
        end
        redirect_to admin_order_path(order_item.order_id)
    end
    
    private
    # =================================================================================
    # order_itemの更新可能項目
    # 製作ステータスが更新可能
    # =================================================================================
    def order_item_params
        params.require(:order_item).permit(:produce_status)
    end
end
