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
#  profile_id      :integer
#

class User < ActiveRecord::Base
  has_secure_password
  REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: REGEX }
  validates :username, presence: true, uniqueness: true
  belongs_to :profile
end
