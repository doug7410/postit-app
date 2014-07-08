class User < ActiveRecord::Base
  attr_accessor :old_password

  has_many :posts
  has_many :comments
  has_many :votes

  before_save :generate_slug!

  has_secure_password validations: false
  validates :username, presence: :true, uniqueness: true
  validates :password, presence: :true, length: {minimum: 6}, on: :create

  validate :old_password_matches?, on: :update, if: :new_password_present?
  validates :password, presence: :true, length: {minimum: 6}, on: :update, allow_blank: true



  def old_password_matches?
    errors.add(:base, "Old password did not match.") if current_password != self.old_password
  end

  def current_password
    BCrypt::Password.new(self.password_digest_was)
  end 

  def new_password_present?
    self.password.present?
  end

  def generate_slug!
    the_slug = to_slug(self.username) #turn the current post title into a slug
    user = User.find_by slug: the_slug #try to find a post with the slug we just created
    count = 2
    while user && user != self #while there is a post object and it's not equal to the current post
      the_slug = append_suffix(the_slug, count) #detirmine the proper suffix and add it to slug
      user = User.find_by slug: the_slug #see if there is a post with the new slug
      count += 1
    end
    self.slug = the_slug.downcase # assign the new slug to the object in lowercase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0 #if the last item in the string is not a number
      #split the string on the dashes, slice off the last item, rejoin on the dashes, 
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s 
     else
      return str + "-" + count.to_s #just add -count to the end
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub!(/\s*[^A-Za-z0-9]\s*/ , '-')
    str.gsub!(/-+/, '-')
    str.downcase
  end

  def to_param
    self.slug
  end

end

