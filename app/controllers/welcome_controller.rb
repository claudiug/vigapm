class WelcomeController < ApplicationController
  def index
    if params[:query]
      @result = Post.where('title LIKE ?', "%#{params[:query]}%")

    end
  end

  def autocomplete
    @result = Post.where('title LIKE ?', "%#{params[:query]}%")
    render json:  @result.map {|s| {name: s.title}}
  end
end

