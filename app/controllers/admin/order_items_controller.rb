class Admin::OrderItemsController < ApplicationController
    
    before_action :authenticate_admin!
    
    # =================================================================================
    # 製造ステータス更新（PATCHアクション）
    # =================================================================================
    def update
        order_item = Order_item.find(params[:id])
        if order_item.update(order_item_params)
            flash[:notice] = "successfully edited the order_item!"
        end
        render :show
    end
    
    private
    # =================================================================================
    # order_itemの更新可能項目
    # 製作ステータスが更新可能
    # =================================================================================
    def order_params
        params.require(:order_item).permit(:status)
    end
end
