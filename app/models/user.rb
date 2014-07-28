class User < ActiveRecord::Base
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true,
                    presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 4 }

  before_save do
    self.email   = email.downcase
    self.api_key = SecureRandom.hex(16)
  end
end
