class PostsController < ApplicationController
  before_action :authorize, only: [:create, :up, :down, :edit, :update, :destroy]

  helper_method :temporarily_id

  respond_to :html, only: %i(create update)

  def index
    params[:page] || 1
    @posts = Post.page(params[:page]).per(20)
  end

  def show
    @post = Post.includes(:comments).find_by(slug: params[:id])
    @post.change_guru!
    @users_follow = @post.users
    impressionist(@post, "PostController", :unique => [:session_hash])
  end

  def new
    @post = Post.new
    @temporarily_id = generate_post_tmp_id
  end

  def create
    @post = current_user.posts.build(posts_params)
    @post.save!

    attach_pictures_to_post

    respond_with @post
  end

  def edit
    @post = Post.find_by(slug: params[:id])
    @temporarily_id = @post.id
  end

  def update
    @post = Post.find_by(slug: params[:id])
    @post.update!(posts_params)

    attach_pictures_to_post

    respond_with @post
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
    params[:post].permit(:title, :body, :tag_list, :slug)
  end

  def temporarily_id
    @temporarily_id || params[:post][:temporarily_id]
  end

  protected

  def generate_post_tmp_id
    tmp_id = 2147483648
    while tmp_id > 2147483647
      tmp_id = SecureRandom.uuid.hex
    end

    tmp_id
  end

  def attach_pictures_to_post
    Post::Picture.where(post_id: temporarily_id).update_all(post_id: @post.id)
  end
end
