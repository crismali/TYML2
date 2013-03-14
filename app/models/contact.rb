class Contact < ActiveRecord::Base
  attr_accessible :contact_id, :user_id

  validates_presence_of :contact_id, :user_id

  validates_uniqueness_of :user_id, :scope => [:contact_id]

  belongs_to :user
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id', primary_key: 'id'
end
