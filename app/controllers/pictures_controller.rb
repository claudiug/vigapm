class PicturesController < ApplicationController
  before_action :authorize, only: :create

  def create
    @picture = Post::Picture.new(post_id: params[:post_id])
    @picture.image = params[:files][0]

    @picture.save
  end
end
