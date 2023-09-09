class CartItem < ApplicationRecord
    
    belongs_to :customer
    belongs_to :item
    
    # 小計取得メソッド
    def subtotal
        item.with_tax_price * amount
    end
end
