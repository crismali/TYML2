class UsersController < ApplicationController

  before_filter :authorize_user, :get_autocomplete_items

  def authorize_user
    if current_user.nil?
      redirect_to signup_url
    end
  end

  def get_autocomplete_items
    @autocomplete_items = @current_user.autocomplete_contacts
  end

  def dashboard
    @received_tymls = @current_user.received_tymls.where(archived: false, receiver_deleted: false).order('created_at desc').to_a
  end

  def sent
    @sent_tymls = @current_user.sent_tymls.where(sender_deleted: false).order('created_at desc').to_a
  end

  def edit
    @archived_tymls = @current_user.received_tymls.where(archived: true, receiver_deleted: false).order('created_at desc').to_a
  end

  def update
    @current_user.update_attributes(params[:user])
    @current_user.remember_token = SecureRandom.urlsafe_base64
    @current_user.save
    unless cookies[:remember_token].nil?
      cookies.permanent[:remember_token] = @current_user.remember_token
    end
    redirect_to settings_url
  end

end
