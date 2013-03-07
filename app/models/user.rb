class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation
  attr_accessible :bio, :email, :location, :name, :profile_pic

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_many :sent_tymls, class_name: 'Tyml', foreign_key: 'sender_id'
  has_many :received_tymls, class_name: 'Tyml', foreign_key: 'receiver_id'
  has_many :contacts

  validate :valid_email

  def valid_email
    unless email[/.+@.+/]
      errors.add(:receiver_email, "must be valid")
    end
  end

end
