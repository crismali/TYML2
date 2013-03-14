class TymlMailer < ActionMailer::Base
  default from: "\"TYML\" <tyml@tyml.it>"

  def new_tyml_notification(tyml)
    @tyml = tyml

    mail to: @tyml.receiver.email, subject: "New TYML from #{@tyml.sender.name}"
  end

  def comment_notification(comment)
    @comment = comment

    if comment.user == comment.tyml.sender && @comment.tyml.receiver.receive_comment_notifications
      mail to: @comment.tyml.receiver.email, subject: "TYML: New comment from #{@comment.tyml.sender.name}"
    elsif @comment.tyml.sender.receive_comment_notifications
      mail to: @comment.tyml.sender.email, subject: "TYML: New comment from #{@comment.tyml.receiver.name}"
    end
  end
end
