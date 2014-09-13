class TagsController < ApplicationController
  impressionist actions: [:show,:index]
  impressionist :unique => [:session_hash, :ip_address]
  def index
    render json: Tag.all
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end
end
