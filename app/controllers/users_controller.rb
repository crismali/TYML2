class UsersController < ApplicationController

  before_filter :authorize_user

  def authorize_user
    if current_user.nil?
      redirect_to new_session_url
    end
  end


  def dashboard
    current_user

    @autocomplete_items = Array.new
    @autocomplete_array = Array.new
    @current_user.contacts.each do |x|
      z = Array.new
      @autocomplete_items << x.contact.email
      z << x.contact.email
      @autocomplete_items << x.contact.name unless x.contact.name.nil?
      z << x.contact.name
      z << x.contact.id
    end
    @autocomplete_items.sort!
  end

  def sent
    current_user
  end


end
