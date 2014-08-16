class PostsController < ApplicationController
  before_action :authorize, only: [:edit, :update] #LOL

  def index
    load_posts
  end

  def show
    load_post
  end

  def new
    build_post
  end

  def create
    build_post
    save_post or render 'new'
  end

  def edit
    load_post
    build_post
  end

  def update
    load_post
    build_post
    save_post or render 'edit'
  end

  def destroy
    load_post
    @post.destroy
    redirect_to posts_path, notice: 'post deleted'
  end

  private

  def posts_scope
    Post.all
  end

  def save_post
    if @post.save
      redirect_to @post, notice: 'post created'
    end
  end

  def build_post
    @post ||= posts_scope.build
    @post.attributes = post_params
  end

  def load_post
    @post ||= Post.find(params[:id])
  end

  def load_posts
    @posts ||= posts_scope.to_a
  end

  def post_params
    post_params = params[:post]
    if post_params
      post_params.permit(:title, :body)
    else
      {}
    end
  end
end
