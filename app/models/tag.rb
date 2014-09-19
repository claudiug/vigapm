# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
  is_impressionable

  def page_view_size
    impressions.size
  end

  TAG_LIMIT = 8
  def self.top_tags
    includes(:impressions).sort_by { |a| a.page_view_size}.reverse.take(TAG_LIMIT)
  end
end

