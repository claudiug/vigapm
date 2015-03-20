class SessionsController < ApplicationController
  layout "auth"
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.permanent[:auth_token] = user.auth_token

      redirect_to session.delete(:redirect_to) || root_url, notice: 'Logged in #{user.username}'
    else
      flash.now.alert = 'Email or password Invalid!'
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session[:user_id] = nil
    redirect_to root_url
  end

end
