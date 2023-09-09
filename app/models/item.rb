class Item < ApplicationRecord
    has_one_attached :image
    
    has_many :cart_item, dependent: :destroy
    
    # 税込価格取得メソッド
    def with_tax_price
        (price * 1.1).floor
    end
    
    # 画像取得メソッド
    def get_image
        unless image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image
    end
end
