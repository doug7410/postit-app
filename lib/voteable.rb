#module using concerns
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes
   total_up_votes - total_down_votes
  end

  def total_up_votes
    self.votes.where(vote: true).size
  end

  def total_down_votes
     self.votes.where(vote: false).size
  end
end



#module Voteable
#
#  def self.includedc(base)
#    base.send(:include, InstanceMethods)
#    base.extend ClassMethods
#    base.class_eval do    #this was in the solutions, but it doesn't work
#      my_class_method
#    end
#  end
#
#  module InstanceMethods
#    def total_votes
#    total_up_votes - total_down_votes
#    end
#
#    def total_up_votes
#      self.votes.where(vote: true).size
#    end
#
#    def total_down_votes
#      self.votes.where(vote: false).size
#    end
#  end
#
#  module ClassMethods
#    def my_class_method
#      puts "Im a class method"
#      has_many :votes, as: :voteable
#    end
#  end
#
#end