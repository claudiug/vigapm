class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Thanks for creating this account and prepare for spam'
    else
      render 'new' #TODO add also a flash message
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    user_params = params[:user]
    user_params.permit(:email, :username, :password)
  end
end
