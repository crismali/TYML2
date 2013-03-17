class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user = User.find_by_remember_token(cookies[:remember_token])
    @current_user = User.find_by_id(session[:user_id]) unless session[:user_id].nil?
    if @current_user.present? && request.remote_ip != @current_user.current_sign_in_ip
      @current_user = nil
    end
    return @current_user
  end

end
