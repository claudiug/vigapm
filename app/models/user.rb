# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  has_secure_password
  attr_reader :ranking
  REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: REGEX }
  validates :username, presence: true, uniqueness: true
  has_one :profile
  has_many :posts
  has_many :comments
  acts_as_voter
  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  has_attached_file :avatar
  validates_attachment_content_type :avatar,
                                    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

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
end
