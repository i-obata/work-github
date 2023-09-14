class Order < ApplicationRecord
    
    enum payment: {credit_card: 0, transfer: 1}
    enum status: {awaiting_payment: 0, payment_confirmation: 1, under_manufacture: 2, preparing_ship: 3, shipped: 4}
    
    belongs_to :customer
    has_many :order_item, dependent: :destroy
    
    # =================================================================================
    # 支払方法(画面表示用)
    # =================================================================================
    def payment_method
        if payment == 0
            payment_i18n[:credit_card]
        elsif payment == 1
            payment_i18n[:transfer]
        end
    end
    
    # =================================================================================
    # 注文ステータス(画面表示用)
    # =================================================================================
    def status_method
        if status == 0
            status_i18n[:awaiting_payment]
        elsif status == 1
            status_i18n[:payment_confirmation]
        elsif status == 2
            status_i18n[:under_manufacture]
        elsif status == 3
            status_i18n[:preparing_ship]
        elsif status == 4
            status_i18n[:shipped]
        end
    end
end
