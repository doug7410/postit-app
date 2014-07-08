class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  before_save :generate_slug!

  validates :name, presence: true, length: {minimum: 3}, uniqueness: true

  def generate_slug!
    the_slug = to_slug(self.name) #turn the current post title into a slug
    category = Category.find_by slug: the_slug #try to find a post with the slug we just created
    count = 2
    while category && category != self #while there is a post object and it's not equal to the current post
      the_slug = append_suffix(the_slug, count) #detirmine the proper suffix and add it to slug
      category = Category.find_by slug: the_slug #see if there is a post with the new slug
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