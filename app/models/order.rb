class Order < ApplicationRecord
    
    enum payment: {credit_card: 0, transfer: 1}
    enum status: {awaiting_payment: 0, payment_confirmation: 1, under_manufacture: 2, preparing_ship: 3, shipped: 4}
    
    belongs_to :customer
    has_many :order_items, dependent: :destroy
    accepts_nested_attributes_for :order_items
    
    # =================================================================================
    # 支払方法(画面表示用)
    # =================================================================================
    def payment_method
        if payment == "credit_card"
            return Order.payments_i18n[:credit_card]
        elsif payment == "transfer"
            return Order.payments_i18n[:transfer]
        end
    end
    
    # =================================================================================
    # 注文ステータス(画面表示用)
    # =================================================================================
    def status_method
        if status == "awaiting_payment"
            return Order.statuses_i18n[:awaiting_payment]
        elsif status == "payment_confirmation"
            return Order.statuses_i18n[:payment_confirmation]
        elsif status == "under_manufacture"
            return Order.statuses_i18n[:under_manufacture]
        elsif status == "preparing_ship"
            return Order.statuses_i18n[:preparing_ship]
        elsif status == "shipped"
            return Order.statuses_i18n[:shipped]
        end
    end
    
    # =================================================================================
    # 注文個数取得
    # =================================================================================
    def total_amount
        result = 0
        order_items.each do |order_item|
            result += result + order_item.amount
        end
        return result
    end
    
end
