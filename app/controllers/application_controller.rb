class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user = User.find_by_remember_token(cookies[:remember_token])
    @current_user ||= User.find_by_id(session[:user_id])
  end

end
