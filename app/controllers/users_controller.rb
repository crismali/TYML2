class UsersController < ApplicationController

  before_filter :authorize_user, :get_autocomplete_items

  def authorize_user
    if current_user.nil?
      redirect_to signin_url
    end
  end

  def get_autocomplete_items
    @autocomplete_items = @current_user.autocomplete_contacts
  end

  def dashboard
    @received_tymls = @current_user.received_tymls.where(archived: false, receiver_deleted: false).order('created_at desc')
  end

  def sent
    @sent_tymls = @current_user.sent_tymls.where(sender_deleted: false).order('created_at desc')
  end

  def edit

  end

end
