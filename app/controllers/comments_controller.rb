class CommentsController < ApplicationController
  before_action :authorize, only: [:create, :up, :down] #LOL
  before_action :find_post, only: [:create]

  respond_to :html, only: :create

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    CommentMail.new_comment(@post, @comment).deliver if @comment.save

    respond_with [@post, @comment], location: post_path(@post)
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

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def find_post
    @post = Post.find_by(slug: params[:post_id])
  end
end
