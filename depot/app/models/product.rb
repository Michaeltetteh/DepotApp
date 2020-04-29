class Product < ApplicationRecord
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equals_to: 0.01}
    validates :title, uniqueness: true 
    validates :image_url, allow_blank: false, format: { 
        with: %r{\.(gif|jpg|png|jpeg)\Z}i,
        message: "🚫not an image.🚫" 
    }   
end
