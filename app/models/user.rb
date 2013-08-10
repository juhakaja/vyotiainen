class User < ActiveRecord::Base

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 99 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :question, presence: true, length: { maximum: 99 }
  validates :answer, presence: true, length: { maximum: 99 }

  has_secure_password
end
