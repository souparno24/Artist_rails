class Post < ApplicationRecord
    
    belongs_to :user
    has_one :category,dependent: :destroy
    has_many :images,dependent: :destroy
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
 
  

  
    
  
    validates :location, presence: true

    VALID_YT_REGEX = /[a-zA-Z0-9]+/
    validates :url, 
    format: { with: VALID_YT_REGEX },presence: true

    validates :description,length: { maximum: 250 }, presence: true
   



   
    private

  def validate_age
      if (Date.today.year-dob.year<18)
          errors.add(:dob, 'Artist should be atleast 18 years old.')
      end
  end


end

