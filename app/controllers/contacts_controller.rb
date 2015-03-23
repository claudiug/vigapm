class ContactsController < ApplicationController
  include SimpleCaptcha::ControllerHelpers

  before_action :authorize

  helper_method :contact_form_message

  def show
  end

  def create
    if simple_captcha_valid? && contact_form_message.present?
      @sent = ContactMailer.feedback_received(current_user, params[:contact].delete(:feedback)).deliver
    end

    render :show
  end

  protected

  def contact_form_message
    params[:contact][:feedback] if params[:contact].present?
  end
end
