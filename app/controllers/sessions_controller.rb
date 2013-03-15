class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])

    if @user.present? && @user.confirmed && @user.authenticate(params[:password])
      if params[:remember_me] == '1'
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
