class OrderItem < ApplicationRecord
    
    enum produce_status: {cannot_be_started: 0, awaiting_manufacture: 1, under_manufacture: 2, complete: 3}
    
    belongs_to :order
    
    # =================================================================================
    # 製作ステータス(画面表示用)
    # =================================================================================
    def status_method
        if produce_status == "cannot_be_started"
            return　OrderItem.produce_statuses_i18n[:cannot_be_started]
        elsif produce_status == "awaiting_manufacture"
            return OrderItem.produce_statuses_i18n[:awaiting_manufacture]
        elsif produce_status == "under_manufacture"
            return OrderItem.produce_statuses_i18n[:under_manufacture]
        elsif produce_status == "complete"
            return OrderItem.produce_statuses_i18n[:complete]
        end
    end

    # =================================================================================
    # 小計取得メソッド
    # =================================================================================
    def subtotal_price
        return (price_including_tax * amount).floor
    end
    
end
