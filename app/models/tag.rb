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
  #before_validation :generate_slug


  # def to_param
  #   slug
  # end
  #
  # def generate_slug
  #   self.slug = name.parameterize
  # end
end

