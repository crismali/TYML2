class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def account_confirmation_email(user)
    @user = user
    mail to: @user.email, subject: "Confirm your account with TYML"
  end

  def reset_password_email(user)
    @user = user
    mail to: @user.email, subject: "Reset your TYML password"
  end


end
