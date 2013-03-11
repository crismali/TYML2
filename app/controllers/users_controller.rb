class UsersController < ApplicationController

  before_filter :authorize_user

  def authorize_user
    if current_user.nil?
      redirect_to new_session_url
    end
  end


  def dashboard
    @autocomplete_items = current_user.autocomplete_contacts
  end

  def sent
    @autocomplete_items = current_user.autocomplete_contacts
  end


end
