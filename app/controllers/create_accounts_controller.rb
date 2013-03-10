class CreateAccountsController < ApplicationController

  def new

  end

  def create

    @user = User.new(params[:user])

    session[:name] = @user.name
    session[:email] = @user.email

    @user.reset_password_sent_at = Time.now

    @user.reset_password_token = SecureRandom.hex(25)

    if @user.save
      #send email containing link to confirm account
      #redirect to page that tells them to go to their email to confirm account
    else
      redirect_to new_user_registration_url
    end

  end

  def resend_confirmation_email
    @user = User.find_by_email(params[:email])

    unless @user.confirmed
      @user.reset_password_sent_at = Time.now

      @user.reset_password_token = SecureRandom.hex(25)

      @user.save

      #resend email
    end

  end

  def confirm
    @user = User.find_by_email(params[:email])

    if @user && (Time.now - @user.reset_password_sent_at) < 60.minutes && @user.reset_password_token == params[:reset_password_token]
      reset_session
      @user.confirmed = true
      @user.reset_password_sent_at = nil
      @user.reset_password_token = nil
      @user.save
      session[:user_id] = @user.id
    else
      redirect_to new_user_registration_url
    end

  end

end
