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
#  slug                    :string(255)
#

class Post < ActiveRecord::Base

  attr_reader :votes
  acts_as_votable
  has_many :comments
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  validates :slug, presence: true
  validates :title, presence: true, uniqueness: true
  validates :title, length: {in: 3..56 }
  before_validation :generate_slug
  has_many :subscriptions
  has_many :subscriptions

  has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy

  is_impressionable

  def to_param
    slug
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts #TODO remove it
    Tag.select('tags.*, count(taggings.tag_id) as count').
        joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    self.tags.pluck(:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

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

  def is_post_subscribe?(user)
    subscriptions.find_by(user_id: user.id)
  end

  private
  def generate_slug
    self.slug = title.parameterize
  end
end
