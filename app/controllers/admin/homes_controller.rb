class Admin::HomesController < ApplicationController
    
    before_action :authenticate_admin!
    
    def top
        @orders = Order.all.order(created_at: :desc)
        @orders = @orders.page(params[:page])
    end
end
