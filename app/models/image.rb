class Image < ApplicationRecord
    belongs_to :post
    belongs_to :user
    has_one_attached :image

    validate :image_type

    private
    def image_type
        if image.attached? == false
            errors.add(:image,"is missing!!!!!")
        end
    end
   
end
