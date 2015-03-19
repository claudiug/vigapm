class ContactMailer < ActionMailer::Base
  default from: 'contact@vigap.com'

  def feedback_received(user, feedback)
    @feedback = feedback

    mail to: 'contact@vigap.com',
         subject: "Vigap Feedback from #{user.username}",
         reply_to: user.email
  end
end
