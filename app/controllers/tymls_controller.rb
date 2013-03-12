class TymlsController < ApplicationController

  def create
    @tyml = Tyml.new(params[:tyml])

    receiver_ids, new_receiver_emails = @tyml.get_receiver_ids

    @tyml.create_tymls_with_receiver_ids(receiver_ids, params[:tyml]) unless receiver_ids.nil?

    @tyml.create_users_and_tymls_via_new_receiver_emails(new_receiver_emails, params[:tyml]) unless new_receiver_emails.empty?


    #these should be sending email notifications, unless the receiver has opted out of the emails

    respond_to do |format|
      format.js
    end

  end

  def update

  end

  def view
    @tyml = Tyml.find(params[:id])
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
    @tyml = Tyml.find(params[:id])
    @tyml.viewed = !@tyml.viewed
    if @tyml.save
      respond_to do |format|
        format.js
      end
    end
  end

  def archive_or_unarchive
    @tyml = Tyml.find(params[:id])
    @tyml.archived = !@tyml.archived
    if @tyml.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @tyml = Tyml.find(params[:id])
    @tyml.destroy
    respond_to do |format|
      format.js
    end
  end



end
