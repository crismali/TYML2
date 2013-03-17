class TymlsController < ApplicationController

  before_filter :authorize_user

  def authorize_user
    if current_user.nil?
      redirect_to signin_url
    end
  end

  before_filter :proper_account_changing_tyml, :only => [ :mark_as_read, :view, :archive_or_unarchive ]

  def proper_account_changing_tyml
    @tyml = Tyml.find(params[:id])
    unless @tyml.receiver_id == @current_user.id
      redirect_to new_session_url
    end
  end

  before_filter :proper_account_creating_or_editing_tyml, :only => :create

  def proper_account_creating_or_editing_tyml
    @tyml = Tyml.new(params[:tyml])
    unless @tyml.sender_id == @current_user.id
      redirect_to new_session_url
    end
  end

  def create

    receiver_ids, new_receiver_emails = @tyml.get_receiver_ids(params[:tyml][:receiver_id])

    @tyml.create_tymls_with_receiver_ids(receiver_ids, params[:tyml]) unless receiver_ids.nil?

    @tyml.create_users_and_tymls_via_new_receiver_emails(new_receiver_emails, params[:tyml]) unless new_receiver_emails.empty?

    respond_to do |format|
      format.js
    end

  end

  def update

  end

  def view
    @tyml.viewed = true
    @tyml.save
    redirect_to @tyml.url
  end

  def edit

  end

  def new
    @autocomplete_items = current_user.autocomplete_contacts

    respond_to do |format|
      format.js
    end

  end

  def mark_as_read
    @tyml.viewed = !@tyml.viewed
    if @tyml.save
      respond_to do |format|
        format.js
      end
    end
  end

  def archive_or_unarchive
    @tyml.archived = !@tyml.archived
    if @tyml.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @tyml = Tyml.find(params[:id])
    if @tyml.sender_id == @current_user.id
      @tyml.sender_deleted = true
    else
      @tyml.receiver_deleted = true
    end

    if @tyml.receiver_deleted && @tyml.sender_deleted
      @tyml.destroy
    end
    respond_to do |format|
      format.js
    end
  end



end
