class WelcomeController < ApplicationController
  def index
    if params[:query]
      @results = Post.where('title LIKE ?', "%#{params[:query]}%")
    end
    params[:page] || 1
    @posts = Post.all.page(params[:page]).per_page(20)
  end

  def autocomplete
    render json: Post.where('title LIKE ?', "%#{params[:query]}%").map {|s| {name: s.title}}
  end
end

