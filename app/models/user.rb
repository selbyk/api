class User < ActiveRecord::Base
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true,
                    presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 4 }

  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: 'followed_id',
                                   class_name:  'Relationship',
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save do
    self.email   = email.downcase
    self.api_key = SecureRandom.hex(16)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
end
