class ProfilesController < ApplicationController

  before_action :authorize

  def index
    @user = current_user
  end

  def new
    @user = current_user
    @profile =  Profile.new
  end

  def create
    @profile = current_user.build_profile(params[:profile].permit(:city, :country, :bio))
    if @profile.save
      redirect_to user_profiles_path
    else
      render :new
    end
  end
end
