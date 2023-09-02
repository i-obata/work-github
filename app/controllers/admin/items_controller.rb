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
    
    def index
        @items = Item.page(params[:page])
    end
    
    def show
        @item = Item.find(params[:id])
    end
    
    def edit
        @item = Item.find(params[:id])
    end
    
    def update
        item = Item.find(params[:id])
        if item.update(item_params)
        flash[:notice] = "successfully edited the user!"
            redirect_to admin_item_path(item.id)
        else
            render :edit
        end
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name, :introduction, :price)
    end\
end
