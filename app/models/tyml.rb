class Tyml < ActiveRecord::Base

  attr_accessible :note, :receiver_id, :sender_id, :url, :viewed, :archived, :statement

  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  has_many :comments

  before_save :add_http_to_url?

  def add_http_to_url?
    unless self.url.include?('http://') || self.url.include?('https://')
      self.url = "http://#{self.url}"
    end
  end

  after_create :send_notification

  def send_notification
    TymlMailer.new_tyml_notification(self).deliver if receiver.receive_new_tyml_notifications
  end

  def get_receiver_ids(params_receiver_id)
    receiver_ids = Array.new
    receiver_names_emails = params_receiver_id.split(',').each {|x| x.strip!}
    sender.contacts.each do |c|
      if receiver_names_emails.include?(c.contact.name)
        receiver_ids << c.contact_id
        receiver_names_emails.delete_at(receiver_names_emails.index(c.contact.name))
      elsif receiver_names_emails.include?(c.contact.email)
        receiver_ids << c.contact_id
        receiver_names_emails.delete_at(receiver_names_emails.index(c.contact.email))
      end
    end
    return receiver_ids.uniq, receiver_names_emails
  end

  def create_tymls_with_receiver_ids(receiver_ids, tyml_params)
    receiver_ids.each do |a_receiver_id|
      new_tyml = Tyml.new(tyml_params)
      new_tyml.receiver_id = a_receiver_id
      new_tyml.save
    end
  end

  def create_users_and_tymls_via_new_receiver_emails(new_receiver_emails, tyml_params)
    new_receiver_emails.each do |receiver_email|
      user = User.find_by_email(receiver_email)
      new_tyml = Tyml.new(tyml_params)
      c = Contact.new
      if user
        c.user_id = sender_id
        c.contact_id = user.id
        c.save
        new_tyml.receiver_id = user.id
        new_tyml.save
      else
        user = User.new
        user.email = receiver_email
        user.password = SecureRandom.hex(10)
        if user.save
          new_tyml.receiver_id = user.id
          new_tyml.save
          c.user_id = sender_id
          c.contact_id = user.id
          c.save
        end

      end
    end
  end


end
