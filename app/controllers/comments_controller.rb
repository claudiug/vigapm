class CommentsController < ApplicationController

  before_action :authorize, only: [:create] #LOL
  before_action :find_post

  def create
    save_comment or redirect_to @post, notice: 'Some error occured'
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def build_comment
    @post.comments.build(comment_params)
  end

  def comment_params
    comment_params = params[:comment]
    if comment_params
      comment_params.permit(:body).merge(user_id: current_user.id)
    else
      {}
    end
  end

  def save_comment
    if build_comment.save!
      redirect_to @post
    end
  end
end
