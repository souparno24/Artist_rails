class Rating < ApplicationRecord
    belongs_to :post
    belongs_to :user
    validates_presence_of :rating
    validates_presence_of :user_id
    validates_presence_of :post_id

   
end
