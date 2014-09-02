class TagsController < ApplicationController

  def index
    render json: Tag.all
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end
end
