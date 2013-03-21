User.destroy_all
Tyml.destroy_all
Contact.destroy_all
Comment.destroy_all

users = [
  {name: 'The TYML Team', email: 'tyml.app@gmail.com', password: 'woohoo', confirmed: true, receive_comment_notifications: false, receive_new_tyml_notifications: false },
  {name: 'Mike McGee', email: 'mike@starterleague.com', bio: 'I did cool things', location: 'Chicago, IL', password: 'woohoo', confirmed: true, remember_token: '1', receive_new_tyml_notifications: false, receive_comment_notifications: false },
  {name: 'Michael Crismali', email: 'michael.crismali@gmail.com', bio: 'I went to a hippy school', location: 'Chicago, IL', password: 'woohoo', confirmed: true, remember_token: '2', receive_new_tyml_notifications: false, receive_comment_notifications: false },
  {name: 'Natasha Postolovski', email: 'npostolovski@gmail.com', bio: 'I did even cooler things', location: 'Melbourne, AU', password: 'woohoo', confirmed: true, remember_token: '3', receive_new_tyml_notifications: false, receive_comment_notifications: false },
  {name: 'Peter Ostrander', email: 'peter.ostrander@gmail.com', bio: 'I have to go to the airport', location: 'Chicago, IL', password: 'woohoo', confirmed: true, remember_token: '5', receive_new_tyml_notifications: false, receive_comment_notifications: false },
  {name: 'Elizabeth Park', email: 'elibeee@gmail.com', bio: 'I like mockups', location: 'Chicago, IL', password: 'woohoo', confirmed: true, remember_token: '4', receive_new_tyml_notifications: false, receive_comment_notifications: false },
  {name: 'Archie Algas', email: 'archie.algas@gmail.com', bio: 'I like mockups even more', location: 'Chicago, IL', password: 'woohoo', confirmed: true, remember_token: '9', receive_new_tyml_notifications: false, receive_comment_notifications: false }
]

User.create users

puts 'Created users'

User.all.each do |user|

  User.all.each do |user2|
    c = Contact.new
    c.user_id = user.id
    c.contact_id = user2.id unless user2 == user
    c.save
  end

end

notes = [ "one kind of note", "different note", "yet another note", "even more notes"]
urls = [ 'http://www.yelp.com/', 'https://www.google.com/', 'https://twitter.com/', 'http://wikipedia.org/', 'https://twitter.com/jeffcohen', 'http://mikeylikey.tumblr.com/']

100.times do
  tyml = Tyml.new
  tyml.statement = notes.sample
  tyml.url = urls.sample
  tyml.sender_id = User.offset(rand(7)).first.id
  tyml.receiver_id = User.offset(rand(7)).first.id

  if rand(2) == 1
    tyml.viewed = true
    tyml.archived = true if rand(2) == 1
  else
    tyml.viewed = false
  end

  tyml.save
end

puts 'Created 100 tymls'

25.times do
  c = Comment.new
  c.user_id = User.offset(rand(7)).first.id
  c.tyml_id = Tyml.offset(rand(100)).first.id
  c.comment_text = notes[rand(4)]
  c.save
end

puts 'Created 25 comments'
