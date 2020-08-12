class User < ApplicationRecord
  has_many :articles
  has_many :comments, dependent: :destroy
  
  # manage secure password
  # rails helper method
  has_secure_password 

  #adding validation 
  validates :email, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  #ensures that the email is valid            
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }            

end
