# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  image                  :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  city                   :string(255)
#  bio                    :string(255)
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
  has_secure_password
  attr_reader :ranking
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: REGEX }
  validates :username, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :ruled_posts, class_name: 'Post', foreign_key: 'guru_id'
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id',
           class_name: 'Relationship',
           dependent:   :destroy

  has_many :followers, through: :reverse_relationships, source: :follower


  has_many :subscriptions
  has_many :subscription_posts, -> { order('created_at DESC') }, through: :subscriptions, source: :post

  acts_as_voter
  has_attached_file :avatar,
                    :styles => {big: '300x300>', medium: '64x64>', thumb: '40x40>'},
                    #:default_url => '/assets/missing-avatar.png'
                    :default_url => lambda { |avatar| avatar.instance.set_default_url}

                        def set_default_url
                                ActionController::Base.helpers.asset_path('missing-avatar.png')
                        end
  validates_attachment_content_type :avatar,
                                    :content_type => %w(image/jpg image/jpeg image/png image/gif)

  def ranking
    result = 0
    result += User.includes(:comments).pluck(:cached_votes_score).delete_if{|x| x == nil}.reduce(:+)
    result += User.includes(:posts).pluck(:cached_votes_score).delete_if{|x| x == nil}.reduce(:+)
  end

  # This method gets user ranking for a single post and post's comments
  def ranking_for(post)
    result = 0
    result += posts.where(id: post).pluck(:cached_votes_score).reduce(:+).to_i
    result += comments.where(post_id: post).pluck(:cached_votes_score).reduce(:+).to_i
    # Add ruled posts?
    # result += posts.where(id: post).pluck(:cached_votes_score).reduce(:+)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
end
