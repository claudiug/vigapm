class ProfilesController < ApplicationController

  before_action :authorize

  def index
    @user = current_user
    @profile = @user.profile
  end

  def new
    @user = current_user
    @profile = @user.profile
  end

  def create
    @profile = Profile.new(params[:profile].permit(:city, :country, :bio))
  end
end
