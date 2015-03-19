class ContactsController < ApplicationController
  include SimpleCaptcha::ControllerHelpers

  before_action :authorize

  def show
  end

  def create
    if simple_captcha_valid? && form_feedback.present?
      @sent = ContactMailer.feedback_received(current_user, params[:contact].delete(:feedback)).deliver
    end

    @feedback_text = form_feedback
    render :show
  end

  protected

  def form_feedback
    params[:contact][:feedback]
  end
end
