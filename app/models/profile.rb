# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  city       :string(255)
#  country    :string(255)
#  bio        :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Profile < ActiveRecord::Base
  belongs_to :user
end
