class CreateAccountsController < ApplicationController

  def new

  end

  def create

    session[:name] = params[:user][:name]
    session[:email] = params[:user][:email]

    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.update_attributes(params[:user])
    else
      @user = User.new(params[:user])
    end

    @user.reset_password_sent_at = Time.now

    @user.reset_password_token = SecureRandom.urlsafe_base64

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

      @user.reset_password_token = SecureRandom.urlsafe_base64

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
      @user.remember_token = SecureRandom.urlsafe_base64
      @user.save
      session[:user_id] = @user.id
    else
      redirect_to new_user_registration_url
    end

  end

end
