class WelcomeController < ApplicationController
  layout "home"

  def index
    if params[:query]
      @results = Post.order('impressions_count DESC').where('title ILIKE ?', "%#{params[:query]}%")
    end
    params[:page] || 1
    @posts = Post.includes(:comments).order('posts.updated_at DESC').page(params[:page]).per(10)
    @top_posts = Post.top_posts
    @top_tags = Tag.top_tags
  end

  def autocomplete
    render(json: Post.where('title ILIKE ?', "%#{params[:query]}%").map do |s|
      { name: s.title, link: post_path(s) }
    end)
  end
end
