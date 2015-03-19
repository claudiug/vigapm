class ContactsController < ApplicationController
  include SimpleCaptcha::ControllerHelpers

  before_action :authorize

  def show
  end

  def create
    if simple_captcha_valid? && params[:contact][:feedback].present?
      @sent = ContactMailer.feedback_received(current_user, params[:contact].delete(:feedback)).deliver
    end

    @feedback_text = params[:contact][:feedback]
    render :show
  end
end
