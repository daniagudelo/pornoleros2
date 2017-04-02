class User < ApplicationRecord
  has_many :scenes
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { minimum: 3, maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { minimum: 3, maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end