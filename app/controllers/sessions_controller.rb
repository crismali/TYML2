class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])

    if @user.present? && @user.confirmed && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Sign-in successful."
    else
      redirect_to new_session_url, :notice => "Sign-in unsuccessful."
    end
  end

  def new

  end

  def destroy
    reset_session
  end

end
