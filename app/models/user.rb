class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true, length: {minimum: 6}
  validates :password_digest, presence: true
  has_many :reviews

  def self.authenticate_with_credentials(email, password)
     #user = User.find_by_email(email.strip)
    user = User.where('lower(email) = ?', email.downcase.strip).first

    if user && user.authenticate(password) #&& password == user[:password]
      return user
    else
      return nil
    end
  end

end
