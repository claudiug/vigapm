# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  body                    :text
#  created_at              :datetime
#  updated_at              :datetime
#  user_id                 :integer
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

class Post < ActiveRecord::Base
  acts_as_votable
  has_many :comments
  belongs_to :user
  self.per_page = 20 #default value for pagination
  #use a post object + user object
  #liked_by -> up vote
  #downvote_from -> down vote
  #votes_for -> all votes
  #get_likes -> just likes size
  #get_dislikes -> down votes size
  #To check if a voter has voted on a model, you can use voted_for?

  def list_of_comments
    comments.to_a if comments.size > 1
  end

  def average_rating
    Post.order(cached_weighted_average: :desc)
  end

  def up_vote(user)
    self.liked_by(user) if self.user != user
  end

  def down_vote(user)
    self.downvote_from(user) if self.user != user
  end
end
