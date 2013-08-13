class User < ActiveRecord::Base

  before_save { email.downcase! }
  before_save { self.admin = false if admin.nil? }
  before_save { self.locked = true if locked.nil? }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 99 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :question, presence: true, length: { maximum: 99 }
  validates :answer, presence: true, length: { maximum: 99 }

  has_secure_password

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
