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
#

class Comment < ActiveRecord::Base
  belongs_to :user
end
