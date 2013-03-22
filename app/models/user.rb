class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :confirmed, :receive_comment_notifications
  attr_accessible :bio, :email, :location, :name, :profile_pic, :receive_new_tyml_notifications, :remember_token
  mount_uploader :profile_pic, ProfilePicUploader

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :sent_tymls, class_name: 'Tyml', foreign_key: 'sender_id'
  has_many :received_tymls, class_name: 'Tyml', foreign_key: 'receiver_id'
  has_many :contacts, class_name: 'Contact', foreign_key: 'user_id'

  validate :valid_email

  after_save do
    team_id = User.find_by_email("tyml.app@gmail.com").id
    Tyml.create(sender_id: team_id, url: "http://picyor.com/", statement: "It's always fun to pick between two options!", receiver_id: self.id)
    Tyml.create(sender_id: team_id, url: "http://fundhero.org/", statement: "If you're interested in helping kids lead better lives, check this out.", receiver_id: self.id)
    Tyml.create(sender_id: team_id, url: "http://platexpectations.herokuapp.com/", statement: "You want your dining experience to be better.", receiver_id: self.id)
    Tyml.create(sender_id: team_id, url: "http://www.startnagging.com/", statement: "You want a better way to get your stuff back from friends.", receiver_id: self.id)
    Tyml.create(sender_id: team_id, url: "http://www.nytimes.com/projects/2012/snow-fall/#/?part=tunnel-creek", receiver_id: self.id, statement: "Who says journalism is dead? Check out this awesome story on NYT.")
    Tyml.create(sender_id: team_id, url: "http://posterous.com/getfile/files.posterous.com/chcameron/r23ep6AmEv7NL0yorhknWtp8wObwkk1D8PTsfJaqx1rJhvQAcFDeQtlwwInp/omfngaaaaaaw.gif", receiver_id: self.id, statement: "This is the best way to show how we feel about you signing up!")
  end

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
