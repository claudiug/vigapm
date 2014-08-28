class PostsController < ApplicationController
  before_action :authorize #only: [:new, :edit, :update, :create] #LOL

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
    @post = current_user.posts.build(posts_params)
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
    @post.up_vote(current_user)
  end

  def down
    @post = Post.find(params[:id])
    @post.down_vote(current_user)
  end

  def posts_params
    params[:post].permit(:title, :body)
  end
end
