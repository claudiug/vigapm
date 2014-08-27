class CommentsController < ApplicationController

  before_action :authorize, only: [:create] #LOL
  before_action :find_post

  def create
    @comment = @post.comments.build(params[:comment].permit(:body))
    @comment.user = current_user
    if @comment.save
      redirect_to @post
    else
      redirect_to @post
    end
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end
end
