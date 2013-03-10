User.destroy_all
Tyml.destroy_all
Contact.destroy_all
Comment.destroy_all

users = [
  {name: 'Mike McGee', email: 'mike@starterleague.com', profile_pic: 'http://assets2.starterleague.com/assets/mike-mcgee-16075ffb857b541ef073ddb483c9bca6.jpg', bio: 'I did cool things', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Michael Crismali', email: 'michael.crismali@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/michael-crismali-01525144b8bc333ee687fbb51832f2ca.jpg', bio: 'I went to a hippy school', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Natasha Postolovski', email: 'npostolovski@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/natasha-postolovski-709bd16708b02bffca8a35e9c75ac809.jpg', bio: 'I did even cooler things', location: 'Melbourne, AU', password: 'woohoo' },
  {name: 'Peter Ostrander', email: 'peter.ostrander@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/peter-ostrander-33542548f4158794e11eb689e08eec6c.jpg', bio: 'I have to go to the airport', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Elizabeth Park', email: 'elibeee@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/elizabeth-park-42c231497c42a6bf78202b8541188f9b.jpg', bio: 'I like mockups', location: 'Chicago, IL', password: 'woohoo' },
  {name: 'Archie Algas', email: 'archie.algas@gmail.com', profile_pic: 'http://portal.starterleague.com/assets/archie-algas-8cb8248639404527654c53b61a1df0e5.jpg', bio: 'I like mockups even more', location: 'Chicago, IL', password: 'woohoo' }
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
  tyml.note = notes[rand(4)]
  tyml.url = urls[rand(6)]
  tyml.sender_id = User.offset(rand(6)).first.id
  tyml.receiver_id = User.offset(rand(6)).first.id

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
  c.user_id = User.offset(rand(6)).first.id
  c.tyml_id = Tyml.offset(rand(100)).first.id
  c.comment_text = notes[rand(4)]
  c.save
end

puts 'Created 25 comments'
