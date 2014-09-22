class PostsController < ApplicationController
  before_action :authorize, only: [:create, :up, :down, :edit, :update, :destroy]

  def index
    params[:page] || 1
    @posts = Post.page(params[:page]).per_page(20)
  end

  def show
    @post = Post.includes(:comments).find_by(slug: params[:id])
    @users_follow = @post.users
    impressionist(@post, "PostController", :unique => [:session_hash])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(posts_params)
    @post.images = params[:post][:images]
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(slug: params[:id])
  end

  def update
    @post = Post.find_by(slug: params[:id])
    if @post.update(posts_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(slug: params[:id])
  end

  def up
    @post = Post.find_by(slug: params[:id])
    @post.up_vote(current_user)
  end

  def down
    @post = Post.find_by(slug: params[:id])
    @post.down_vote(current_user)
  end

  def users_follow
    @post = Post.find_by(slug: params[:id])
    @users_follow = @post.users
    render json: @users_follow
  end

  def posts_params
    params[:post].permit(:title, :body, :tag_list, :slug, :images)
  end
end
