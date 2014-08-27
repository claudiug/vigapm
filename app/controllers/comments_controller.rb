class CommentsController < ApplicationController

  before_action :authorize, only: [:create] #LOL
  before_action :find_post

  def create
    @comment = @post.comments.build(params[:comment].permit(:body))
    @comment.user = current_user
    if @comment.save
      CommentMail.new_comment(current_user).deliver #TODO send in a thread
      redirect_to @post
    else
      redirect_to @post
    end
  end

  def up
    @comment = Comment.find(params[:id])
    @comment.up_vote(current_user)
  end

  def down
    @comment = Comment.find(params[:id])
    @comment.down_vote(current_user)
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end
end
