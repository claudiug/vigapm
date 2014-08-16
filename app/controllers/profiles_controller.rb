class ProfilesController < ApplicationController

  before_action :find_user_for_profile, only: [:new, :create, :show]
  def new
    build_empty_profile
  end

  def create
    save_profile or render :new
  end

  def show
    load_profile
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'profile updated'
    else
      render edit
    end
  end

  def destroy
    load_profile
    @profile.destroy
    redirect_to root_url
  end

  private

  def profile_params
    params[:profile].permit(:city, :country, :bio)
  end

  def find_user_for_profile
    @user = User.find(params[:user_id])
  end

  def build_empty_profile
    @profile = @user.build_profile
  end

  def save_profile
    build_empty_profile.attributes = profile_params
    if @profile.save
      redirect_to [@user, @profile], notice: 'Profile Updated'
    end
  end

  def load_profile
    @profile ||= Profile.find(params[:id])
  end
end
