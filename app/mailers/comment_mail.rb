class CommentMail < ActionMailer::Base
  default from: "Vigap <no-reply@vigap.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mail.new_comment.subject
  #
  def new_comment(post, comment)
    @post = post
    @comment = comment

    mail to: post.user.email, subject: "New comment on \"" + post.title + "\"" if post.user.username
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
