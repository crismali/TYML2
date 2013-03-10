class ResetPasswordsController < ApplicationController

  def new
    #reset password form page
  end

  def send_reset_password
    @user = User.find_by_email(params[:email])

    @user.reset_password_sent_at = Time.now

    @user.reset_password_token = SecureRandom.hex(25)

    if @user.save
      #send email
      redirect_to #confirmation page?
    else
      redirect_to #the forgot password page
    end

  end

  def reset_password
    @user = User.find_by_email(params[:email])

    if @user && (Time.now - @user.reset_password_sent_at) < 60.minutes && @user.reset_password_token == params[:reset_password_token]
      reset_session
      @user.confirmed = true
      @user.reset_password_sent_at = nil
      @user.reset_password_token = nil
      @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_url
    else
      redirect_to #forgot password page
    end


  end

end
