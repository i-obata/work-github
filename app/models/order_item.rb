class OrderItem < ApplicationRecord
    
    enum status: {cannot_be_started: 0, awaiting_manufacture: 1, under_manufacture: 2, complete: 3}
    
    belongs_to :order
    
    # =================================================================================
    # 製作ステータス(画面表示用)
    # =================================================================================
    def status_method
        if status == 0
            return　status_i18n[:cannot_be_started]
        elsif status == 1
            return status_i18n[:awaiting_manufacture]
        elsif status == 2
            return status_i18n[:under_manufacture]
        elsif status == 3
            return status_i18n[:complete]
        end
    end

    # =================================================================================
    # 小計取得メソッド
    # =================================================================================
    def subtotal_price
        return (price_including_tax * amount).floor
    end
end
