class User < ActiveRecord::Base

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)&.authenticate(password)
  end

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false } 
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  
end
