class TymlsController < ApplicationController

  def create
    @tyml = Tyml.new(params[:tyml])

    @tyml.save

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
