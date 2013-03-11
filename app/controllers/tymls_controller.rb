class TymlsController < ApplicationController

  def create
    @tyml = Tyml.new(params[:tyml])

    receiver_ids, new_receiver_emails = @tyml.get_receiver_ids

    receiver_ids.each do |a_receiver_id|
      new_tyml = Tyml.new(params[:tyml])
      new_tyml.receiver_id = a_receiver_id
      new_tyml.save
    end

    new_receiver_emails.each do |receiver_email|
      user = User.find_by_email(receiver_email)
      new_tyml = Tyml.new(params[:tyml])
      c = Contact.new
      if user
        c.user_id = @tyml.sender_id
        c.contact_id = user.id
        c.save
        new_tyml.receiver_id = user.id
        new_tyml.save
      else
        user = User.new
        user.email = receiver_email
        if user.save
          new_tyml.receiver_id = user.id
          new_tyml.save
          c.user_id = @tyml.sender_id
          c.contact_id = user.id
          c.save
        end
      end
    end


    respond_to do |format|
      format.js
    end

  end

  def update

  end

  def new
    @autocomplete_items

    respond_to do |format|
      format.js
    end
  end


end
