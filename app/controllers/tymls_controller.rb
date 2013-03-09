class TymlsController < ApplicationController

  def create
    @tyml = Tyml.new(params[:tyml])

    @tyml.save

    respond_to do |format|
      format.js
    end

  end


end
