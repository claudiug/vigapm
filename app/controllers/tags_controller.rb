class TagsController < ApplicationController

  def show
    @tags = Tag.find(params[:id])
  end
end
