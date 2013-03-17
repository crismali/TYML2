class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user.present? && @user.authenticate(params[:password]) && @user.confirmed
      @user.last_sign_in_ip = @user.current_sign_in_ip
      @user.current_sign_in_ip = request.remote_ip
      @user.last_sign_in_at = @user.current_sign_in_at
      @user.current_sign_in_at = Time.now
      @user.sign_in_count = @user.sign_in_count + 1
      @user.save
      if params[:remember_me] == '1'
        @user.remember_token = SecureRandom.urlsafe_base64
        @user.save
        cookies.permanent[:remember_token] = @user.remember_token
      else
        session[:user_id] = @user.id
      end
      redirect_to root_url, :notice => "Sign-in successful."
    else
      redirect_to new_session_url, :notice => "Sign-in unsuccessful."
    end
  end

  def new

  end

  def destroy
    cookies.delete(:remember_token)
    reset_session
    redirect_to signin_url
  end

end
