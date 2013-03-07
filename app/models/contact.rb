class Contact < ActiveRecord::Base
  attr_accessible :contact_id, :user_id

  validates_presence_of :contact_id, :user_id

  validate :unique_pair_of_users

  def unique_pair_of_users
    if Contact.where(user_id: self.user_id, contact_id: self.contact_id).count > 1
      errors.add(:contact_id, "That person is already a contact.")
      logger.info(errors.inspect)
    end
  end

  belongs_to :user
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id', primary_key: 'id'
end
