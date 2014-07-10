class User < ActiveRecord::Base
  attr_accessor :old_password

  include Slugable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: :true, uniqueness: true
  validates :password, presence: :true, length: {minimum: 6}, on: :create

  validate :old_password_matches?, on: :update, if: :new_password_present?
  validates :password, presence: :true, length: {minimum: 6}, on: :update, allow_blank: true

  def slug_column
    self.username
  end

  def old_password_matches?
    errors.add(:base, "Old password did not match.") if current_password != self.old_password
  end

  def current_password
    BCrypt::Password.new(self.password_digest_was)
  end 

  def new_password_present?
    self.password.present?
  end

end

