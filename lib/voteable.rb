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