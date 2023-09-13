class Order < ApplicationRecord
    
    enum payment_method: {credit_card: 0, transfer: 1}
    
    belongs_to :customer
    
    # 支払方法
    def payment_method
        if payment == 0
            payment_i18n[:credit_card]
        elsif payment == 1
            payment_i18n[:transfer]
        end
    end
end
