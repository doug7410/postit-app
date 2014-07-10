module Slugable
    extend ActiveSupport::Concern


    
    included do
      before_save :generate_slug!
    end

    def generate_slug!
      the_slug = to_slug(slug_text) #turn the current post title into a slug
      
      object = self.class.find_by slug: the_slug #try to find the object with the slug we just created
      count = 2
      while object && object != self #while there is an object and it's not equal to the current object
        the_slug = append_suffix(the_slug, count) #detirmine the proper suffix and add it to slug
        object = self.class.find_by slug: the_slug #see if there is a post with the new slug
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

    def slug_text
      if self.class.name == 'Post'
        self.title
      elsif self.class.name == 'Category'
        self.name
      elsif self.class.name == 'User'
        self.username
      end
    end

end