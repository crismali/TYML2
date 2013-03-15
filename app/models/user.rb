class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :confirmed, :receive_comment_notifications
  attr_accessible :bio, :email, :location, :name, :profile_pic, :receive_new_tyml_notifications, :remember_token

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :sent_tymls, class_name: 'Tyml', foreign_key: 'sender_id'
  has_many :received_tymls, class_name: 'Tyml', foreign_key: 'receiver_id'
  has_many :contacts, class_name: 'Contact', foreign_key: 'user_id'

  validate :valid_email

  def valid_email
    unless email[/.+@.+/]
      errors.add(:email, "must be valid")
    end
  end

  def autocomplete_contacts
    autocomplete_items = Array.new
    contacts.each do |x|
      autocomplete_items << x.contact.email
      autocomplete_items << x.contact.name unless x.contact.name.nil?
    end
    autocomplete_items.sort!
  end

end
