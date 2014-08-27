class PostsController < ApplicationController
  before_action :authorize, only: [:edit, :update] #LOL

  def index
    params[:page] || 1
    @posts = Post.all.page(params[:page]).per_page(20)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:title, :body))
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
  end

  def up
    @post = Post.find(params[:id])
    load_post.up_vote(current_user)
  end

  def down
    @post = Post.find(params[:id])
    load_post.down_vote(current_user)
  end
end
