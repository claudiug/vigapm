class CommentMail < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mail.new_comment.subject
  #
  def new_comment
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
