class Public::CartItemsController < ApplicationController
    
    def create
        cart_item = Cart_item.new(cart_item_params)
        cart_items = Cart_Item.where(customer_id: current_customer.id)
        if cart_items.item.find_by(name: cart_item.item.name)
            cur_cart_item = cart_items.item.find_by(name: cart_item.item.name)
            cur_cart_item.amount += cart_item.amount.to_i
            cur_cart_item.update(cart_item_params)
            flash[:notice] = "successfully submitted the cart!"
            redirect_to cart_items_path
        else    
            if cart_item.save
                flash[:notice] = "successfully submitted the cart!"
                redirect_to cart_items_path
            else
                @item = Item.find(id: cart_item.item_id)
                render template: "public/items/show"
            end
        end
    end
    
    def index
        @cart_items = Cart_Item.where(customer_id: current_customer.id)
        @totalprice = 0
    end
    
    def update
        cart_item = Cart_Item.find(params[:id])
        if cart_item.update(cart_item_params)
        flash[:notice] = "successfully edited the cart!"
            @cart_items = Cart_Item.where(customer_id: current_customer.id)
            render template: "public/cart_items"
        else
            render :index
        end
    end
    
    def destroy
        cart_item = Cart_Item.find(params[:id])
        if cart_item.destroy
            flash[:notice] = "The cart was successfully destroyed."
            @cart_items = Cart_Item.where(customer_id: current_customer.id)
            render template: "public/cart_items"
        end
    end
    
    def destroy_all
        cart_items = Cart_Item.where(customer_id: current_customer.id)
        if cart_items.destroy
            flash[:notice] = "The cart was successfully destroyed all."
            @cart_items = Cart_Item.where(customer_id: current_customer.id)
            render template: "public/cart_items"
        end
    end
    
    private
    
    def cart_item_params
        params.require(:cart_item).permit(:amount)
    end
end
