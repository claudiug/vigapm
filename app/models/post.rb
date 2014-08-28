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

  attr_reader :votes
  acts_as_votable
  has_many :comments
  belongs_to :user

  def list_of_comments
    comments.to_a if comments.length > 0
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

  def votes
    {
        up: self.get_upvotes.size,
        down: self.get_downvotes.size
    }
  end

  def post_ranking
    self.get_upvotes.size - self.get_downvotes.size
  end
end
