class SubscriptionsController < ApplicationController
  before_action :authorize

  def create
    @post = Post.find(params[:subscription][:post_id])
    @post.subscriptions.create!(user_id: current_user.id)
    redirect_to @post
  end

  def destroy
    @post = Post.find((params[:subscription][:post_id]))
    Subscription.find(params[:id]).destroy
    redirect_to @post
  end
end
