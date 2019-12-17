class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :email, presence: true
  validates :password, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  before_save { email.downcase! }

  def self.authenticate_with_credentials(email, password)
    trim = email.strip!
    if trim 
      input = trim
    else
      input = email
    end 
    user = User.find_by_email(input.downcase)
    if user && user.authenticate(password)
      user
    else 
      nil
    end
  end
end
