class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      @tyml = @comment.tyml
     # TymlMailer.comment_notification(@comment).deliver

      respond_to do |format|
        format.js
      end
    end
  end

  def destroy

  end

end
