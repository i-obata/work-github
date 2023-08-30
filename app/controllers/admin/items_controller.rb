class Admin::ItemsController < ApplicationController
    
    def new
        @item = Item.new
    end
  
    def create
        @item = Item.new(item_params)
        if @item.save
            flash[:notice] = "successfully submitted the item!"
            redirect_to admin_item_path(@item.id)
        else
            render :new
        end
    end
end
