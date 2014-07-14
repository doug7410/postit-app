class User < ActiveRecord::Base
  attr_accessor :old_password

  include SluggableDoug

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: :true, uniqueness: true
  validates :password, presence: :true, length: {minimum: 6}, on: :create

  validate :old_password_matches?, on: :update, if: :new_password_present?
  validates :password, presence: :true, length: {minimum: 6}, on: :update, allow_blank: true

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) #rendom 6 digit number
  end

  def remove_pin!
    self.update_column(:pin, nil) #rendom 6 digit number
  end

  def send_pin_to_twilio

    # put your own credentials here 
    account_sid = 'ACb62e32327e8ec258781341a039e65c46' 
    auth_token = 'a4987dc755a5f8be041d4b573d32f896' 
    message = "Hi #{self.username}, please input this pin (#{self.pin}) to continue login" 
    
    # set up a client to talk to the Twilio REST API 
    begin

      client = Twilio::REST::Client.new account_sid, auth_token      
      client.account.messages.create({
        :from => '+15619238682', 
        :to => self.phone, 
        :body => message  
      })
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
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

  def admin?
    self.role == 'admin'
  end

  def current_vote(obj)
    if self.has_voted_on_this?(obj)
      self.votes.find_by(voteable: obj).vote
    else
      nil
    end
  end

  def has_voted_on_this?(obj)
    Vote.find_by(user_id: self.id, voteable: obj)
  end

end

