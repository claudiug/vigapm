# == Schema Information
#
# Table name: post_pictures
#
#  id                 :integer          not null, primary key
#  post_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Post
  class Picture < ActiveRecord::Base
    belongs_to :post

    has_attached_file :image,
                      styles: { medium: '300x300>', thumb: '100x100>' },
                      default_url: '/images/:style/missing.png'

    validates_attachment :image,
                         content_type: { content_type: /\Aimage\/.*\Z/ },
                         size: { in: 0..10.megabytes }
  end
end
