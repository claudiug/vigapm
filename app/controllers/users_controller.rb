class UsersController < ApplicationController
  before_action :authorize, only: [:followers, :following, :show]
  layout 'auth', only: %i(new create)

  respond_to :html, only: :create

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Thanks for creating this account and prepare for spam'
    end

    respond_with @user, location: root_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      redirect_to @user
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.followed_users
    render 'show_follow'
  end

  def user_follow_posts
    @user = User.find(params[:id])
    @posts = @user.followed_posts
    render json: @posts
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    user_params = params[:user]
    user_params.permit(:email, :username, :password, :avatar, :city, :bio, :followed_id)
  end
end
