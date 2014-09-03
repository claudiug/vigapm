class CommentsController < ApplicationController

  before_action :authorize, only: [:create, :up, :down] #LOL
  before_action :find_post, only: [:create]

  def create
    @comment = @post.comments.build(params[:comment].permit(:body))
    @comment.user = current_user
    if @comment.save
      CommentMail.new_comment(@post, @comment).deliver #TODO send in a thread
      redirect_to @post
    else
      redirect_to @post
    end
  end

  def up
    @comment = Comment.find(params[:id])
    @comment.up_vote(current_user)
    CommentMail.new_up_vote(current_user, @comment)
  end

  def down
    @comment = Comment.find(params[:id])
    @comment.down_vote(current_user)
    CommentMail.new_down_vote(current_user, @comment)
  end

  private
  def find_post
    @post = Post.find_by(slug: params[:post_id])
  end
end
