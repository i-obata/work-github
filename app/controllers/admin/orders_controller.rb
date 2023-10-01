class Admin::OrdersController < ApplicationController
    
    before_action :authenticate_admin!
    
    # =================================================================================
    # 注文詳細画面（GETアクション）
    # =================================================================================
    def show
        @order = Order.find(params[:id])
    end
    
    # =================================================================================
    # 注文ステータス更新（PATCHアクション）
    # =================================================================================
    def update
        order = Order.find(params[:id])
        if order.update(order_params)
            flash[:notice] = "successfully edited the order!"
        end
        render :show
    end
    
    private
    # =================================================================================
    # orderの更新可能項目
    # 注文ステータスが更新可能
    # =================================================================================
    def order_params
        params.require(:order).permit(:status)
    end
end
