class TymlMailer < ActionMailer::Base
  default from: "\"TYML\" <tyml@tyml.it>"

  def new_tyml_notification(tyml)
    @tyml = tyml

    mail to: @tyml.receiver.email, subject: "New TYML from #{@tyml.sender.name}"
  end

  def comment_notification(comment)
    @comment = comment
    @comment_receiver = User.find_by_email(comment.tyml.receiver_email)

    if comment.user == comment.tyml.sender
      mail to: @comment.tyml.receiver.email, subject: "TYML: New comment from #{@comment.tyml.sender.name}"
    else
      mail to: @comment.tyml.sender.email, subject: "TYML: New comment from #{@comment.receiver.name}"
    end
  end
end
