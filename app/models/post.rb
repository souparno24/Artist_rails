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
    validate :validate_age
 
  

  
    
    validates :category, presence: true

    validates :location, presence: true

    VALID_YT_REGEX = /[a-zA-Z0-9]+/
    validates :url, 
    format: { with: VALID_YT_REGEX },presence: true

    validates :description,length: { maximum: 250 }, presence: true
    def self.search_by(search_term)
        where("LOWER(name) LIKE :search_term OR LOWER(category) LIKE :search_term",search_term: "%#{search_term.downcase}%")
    end
    private

  def validate_age
      if dob.present? && dob > 18.years.ago.to_i
          errors.add(:dob, 'You should be over 18 years old.')
      end
  end
end

