class Post < ApplicationRecord
    belongs_to :user
    has_many :comments,dependent: :destroy
    has_many :stars,dependent: :destroy

    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
                      
                      
    validates :dob, presence: true
    validates :category, presence: true
    validates :location, presence: true
    validates :url, presence: true
    validates :description, presence: true
    def self.search_by(search_term)
        where("LOWER(name) LIKE :search_term OR LOWER(category) LIKE :search_term",search_term: "%#{search_term.downcase}%")
    end
end
