class Public::CartItemsController < ApplicationController
    
    def create
        cart_item = Cart_item.new(cart_item_params)
        if cart_item.save
            flash[:notice] = "successfully submitted the cart!"
            # redirect_to admin_item_path(@cart_item.id)
        else
            @item = Item.find_by(id: cart_item.item_id)
            @cart_item = Cart_item.new
            render template: "public/items/show"
        end
    end
    
    def index
    end
    
    def update
    end
    
    def destroy
    end
    
    def destroy_all
    end
end
