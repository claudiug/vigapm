class WelcomeController < ApplicationController
  def index
    if params[:query]
      @results = Post.where('title LIKE ?', "%#{params[:query]}%")
    end
  end

  def autocomplete
    render json: Post.where('title LIKE ?', "%#{params[:query]}%").map {|s| {name: s.title}}
  end
end

