class Comment < ActiveRecord::Base

  include VoteableDoug

  belongs_to :post
  belongs_to :user
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :body, presence: :true

end