class User < ActiveRecord::Base

  before_save { email.downcase! }
  before_save { self.admin = false if admin.nil? }
  before_save { self.locked = true if locked.nil? }

  validates :name, presence: true, length: { maximum: 99 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :question, presence: true, length: { maximum: 99 }
  validates :answer, presence: true, length: { maximum: 99 }

  has_secure_password
end
