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
#  images_file_name        :string(255)
#  images_content_type     :string(255)
#  images_file_size        :integer
#  images_updated_at       :datetime
#

class Post < ActiveRecord::Base
  acts_as_votable
  has_many :comments
  belongs_to :user
  belongs_to :guru, class_name: 'User'
  has_many :taggings
  has_many :tags, through: :taggings
  validates :slug, presence: true
  validates :title, presence: true, uniqueness: true
  validates :title, length: {in: 3..56}
  before_validation :generate_slug
  has_many :subscriptions
  has_many :subscriptions

  has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy
  has_many :commentators, through: :comments, source: :user

  has_attached_file :images, styles: {medium: '300x300>', thumb: '100x100>'}, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :images, :content_type => /\Aimage\/.*\Z/

  validates_attachment :images, content_type: {content_type: 'image/jpeg'}, size: {in: 0..10.megabytes}

  is_impressionable counter_cache: true

  def page_view_size
    impressions.size
  end

  #TODO refactor this, many, many queries
  #TODO REFACTOR
  PAGE_VIEWS = 100
  ACTIVITY = 20

  def change_guru!
    if seeking_new_guru? && guru_should_leave?
      self.update!(guru: guru_candidate)
    end
  end

  POST_LIMIT = 9

  def self.top_posts
    includes(:comments, :impressions).sort_by { |a| a.page_view_size }.reverse.take(POST_LIMIT)
  end

  def to_param
    slug
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def tag_list
    self.tags.pluck(:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
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

  def post_total_votes
    self.get_upvotes.size + self.get_downvotes.size
  end

  def post_ranking
    self.get_upvotes.size - self.get_downvotes.size
  end

  def is_post_subscribe?(user)
    subscriptions.find_by(user_id: user.id)
  end

  def user_voters
    votes_for.by_type(User).voters
  end

  protected

  def seeking_new_guru?
    return if system_post?

    self.impressions_count > PAGE_VIEWS && self.comments.size > 1 && post_activity > ACTIVITY
  end

  # This one probably should use separate field for checking if user is an admin
  def system_post?
    user.username == 'Vigap'
  end

  def post_activity
    @post_votes ||= post_total_votes
    @comments_votes ||= comments.map do |c|
      c.comment_total_votes
    end.reduce(:+)
    @post_votes + @comments_votes
  end

  def guru_should_leave?
    guru.ranking_for(self) < guru_candidate.ranking_for(self)
  end

  def guru_candidate
    commentators.sort_by { |c| c.ranking_for(self) }.reverse.first
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
