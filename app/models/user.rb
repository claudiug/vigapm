# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string(255)
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  password_digest     :string(255)
#  image               :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  is_guru             :boolean          default(FALSE)
#  city                :string(255)
#  bio                 :string(255)
#

class User < ActiveRecord::Base
  has_secure_password
  attr_reader :ranking

  REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: REGEX }
  validates :username, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id',
           class_name: 'Relationship',
           dependent:   :destroy

  has_many :followers, through: :reverse_relationships, source: :follower


  has_many :subscriptions
  has_many :subscription_posts, through: :subscriptions, source: :post

  acts_as_voter
  has_attached_file :avatar,
                    :styles => {big: '300x300>', medium: '64x64>', thumb: '40x40>'},
                    :default_url => '/assets/missing-avatar.png'
  validates_attachment_content_type :avatar,
                                    :content_type => %w(image/jpg image/jpeg image/png image/gif)

  def ranking
    result = 0
    self.posts.each do |r|
      result +=r.post_ranking rescue nil
    end
    self.comments.each do |r|
      result += r.comment_ranking rescue nil
    end
    result
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
