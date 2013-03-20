class Comment < ActiveRecord::Base
  attr_accessible :comment_text, :tyml_id, :user_id
  validates_presence_of :comment_text, :tyml_id, :user_id
  belongs_to :tyml
  belongs_to :user

  after_save :send_notification

  def send_notification
    TymlMailer.comment_notification(self).deliver
  end

  def format_for_embedly
    c = comment_text

    split_string = c.split.map! do |s|
      if s.include?(".gif")    || s.include?(".jpg")     || 
         s.include?(".png")    || s.include?(".jpeg")    || 
         s.include?("http://") || s.include?("https://") || 
         s.include?("www.")
         s = "<a href='#{s}'>" + "#{s}" + "</a>"
         s
      else
         s
      end
    end

    split_string.join(' ')
  end

end
