class CommentMail < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mail.new_comment.subject
  #
  def new_comment(user, comment)
    @greeting = comment

    mail to: user.email
  end

  def new_up_vote(user, comment)
    @user = user
    @comment = comment
  end

  def new_down_vote(user, comment)
    @user = user
    @comment = comment
  end
end
