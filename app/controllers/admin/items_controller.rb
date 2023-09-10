class Admin::ItemsController < ApplicationController
    
    # =================================================================================
    # 商品新規登録画面（GETアクション）
    # =================================================================================
    def new
        @item = Item.new
    end
  
    # =================================================================================
    # 商品情報の新規登録（POSTアクション）
    # =================================================================================
    def create
        @item = Item.new(item_params)
        if @item.save
            flash[:notice] = "successfully submitted the item!"
            redirect_to admin_item_path(@item.id)
        else
            render :new
        end
    end
    
    # =================================================================================
    # 商品一覧画面（GETアクション）
    # =================================================================================
    def index
        @items = Item.page(params[:page])
    end
    
    # =================================================================================
    # 商品詳細画面（GETアクション）
    # =================================================================================
    def show
        @item = Item.find(params[:id])
    end
    
    # =================================================================================
    # 商品編集画面（GETアクション）
    # =================================================================================
    def edit
        @item = Item.find(params[:id])
    end
    
    # =================================================================================
    # 商品情報の更新処理（PATCHアクション）
    # =================================================================================
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
    
    # =================================================================================
    # itemの更新可能項目
    # 商品名、商品説明文、税抜価格が更新可能
    # =================================================================================
    def item_params
        params.require(:item).permit(:name, :introduction, :price)
    end
end
