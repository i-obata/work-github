class Public::CartItemsController < ApplicationController
    
    # =================================================================================
    # カート内商品データ追加処理（POSTアクション）
    # =================================================================================
    def create
        cart_item = Cart_item.new(cart_item_params)
        cart_items = Cart_Item.where(customer_id: current_customer.id)
        
        # 既にカート内に同じ商品が存在する場合
        if cart_items.item.find_by(name: cart_item.item.name)
            
            # カート内の商品の数量を増やす
            cur_cart_item = cart_items.item.find_by(name: cart_item.item.name)
            cur_cart_item.amount += cart_item.amount.to_i
            cur_cart_item.update(cart_item_params)
            flash[:notice] = "successfully submitted the cart!"
            redirect_to cart_items_path
            
        # カート内に同じ商品が存在しない場合、新規追加
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
    
    # =================================================================================
    # カート内商品一覧画面（GETアクション）
    # =================================================================================
    def index
        @cart_items = Cart_Item.where(customer_id: current_customer.id)
        @totalprice = 0
    end
    
    # =================================================================================
    # カート内商品データ更新処理（PATCHアクション）
    # =================================================================================
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
    
    # =================================================================================
    # カート内商品データ削除（1商品）処理（DELETEアクション）
    # =================================================================================
    def destroy
        cart_item = Cart_Item.find(params[:id])
        if cart_item.destroy
            flash[:notice] = "The cart was successfully destroyed."
            @cart_items = Cart_Item.where(customer_id: current_customer.id)
            render template: "public/cart_items"
        end
    end
    
    # =================================================================================
    # カート内商品データ削除（全商品）処理（DELETEアクション）
    # =================================================================================
    def destroy_all
        cart_items = Cart_Item.where(customer_id: current_customer.id)
        if cart_items.destroy
            flash[:notice] = "The cart was successfully destroyed all."
            @cart_items = Cart_Item.where(customer_id: current_customer.id)
            render template: "public/cart_items"
        end
    end
    
    private
    
    # =================================================================================
    # cart_itemの更新可能項目
    # 数量が更新可能
    # =================================================================================
    def cart_item_params
        params.require(:cart_item).permit(:amount)
    end
end
