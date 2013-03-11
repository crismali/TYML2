class Tyml < ActiveRecord::Base

  attr_accessible :note, :receiver_id, :sender_id, :url, :viewed

  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  has_many :comments

  def get_receiver_ids
    receiver_ids = Array.new
    receiver_names_emails = receiver_id.split(',')
    sender.contacts.each do |c|
      if receiver_names_emails.include?(c.contact.name)
        receiver_ids << c.contact_id
        receiver_names_emails.delete_at(receiver_names_emails.index(c.contact.name))
      elsif receiver_names_emails.include?(c.contact.email)
        receiver_ids << c.contact_id
        receiver_names_emails.delete_at(receiver_names_emails.index(c.contact.email))
      end
    end
    return receiver_ids.uniq!, receiver_names_emails
  end

end
