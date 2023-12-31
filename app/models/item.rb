class Item < ApplicationRecord
    has_one_attached :profile_image
    
    has_many :cart_item, dependent: :destroy
    
    # 税込価格取得メソッド
    def with_tax_price
        return (price * 1.1).floor
    end
    
    # 画像取得メソッド
    def get_profile_image(width, height)
        unless profile_image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        profile_image.variant(resize_to_limit: [width,height]).processed
    end
end
