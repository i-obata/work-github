class Address < ApplicationRecord
    
    belongs_to :customer
    
    validates :postal_code, presence: true
    validates :address, presence: true
    validates :destination, presence: true
    
    # =================================================================================
    # 画面表示用配送先取得処理
    # 郵便番号、住所、宛先を結合
    # =================================================================================
    def address_display
        '〒' + postal_code + ' ' + address + ' ' + destination
    end
end
