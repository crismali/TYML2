class Comment < ActiveRecord::Base
  attr_accessible :comment_text, :tyml_id, :user_id
  validates_presence_of :comment_text, :tyml_id, :user_id
  belongs_to :tyml
  belongs_to :user

  after_save :send_notification

  def send_notification
    #TymlMailer.comment_notification(self).deliver
  end

end
