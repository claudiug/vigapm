# == Schema Information
#
# Table name: comments
#
#  id                      :integer          not null, primary key
#  body                    :text
#  created_at              :datetime
#  updated_at              :datetime
#  post_id                 :integer
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  user_id                 :integer
#  ancestry                :string(255)
#  parent_id               :integer
#

class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :user


  def comment_ranking
    self.get_upvotes.size - self.get_downvotes.size
  end

  def up_vote(user)
    self.liked_by(user) if self.user != user
  end

  def down_vote(user)
    self.downvote_from(user) if self.user != user
  end

  def comments_votes
    {
        up: self.get_upvotes.size,
        down: self.get_downvotes.size
    }
  end

  def comment_total_votes
    comments_votes[:up] + comments_votes[:down]
  end
end
