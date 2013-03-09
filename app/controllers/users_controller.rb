class UsersController < ApplicationController

  before_filter :authorize_user

  def authorize_user
    if session[:user_id].nil?
      redirect_to new_session_url
    end
  end


  def dashboard
    current_user
    @autocomplete_items = @current_user.contacts.map { |x| x.contact.email}
    # @autocomplete_items = @current_user.contacts.map do |x|
    #   z = Array.new
    #   z << x.contact.email if x.contact.name.nil?
    #   z << x.contact.name unless x.contact.name.nil?
    #   z << x.contact_id
    #   z
    # end
  end

  def sent
    current_user
  end


end
