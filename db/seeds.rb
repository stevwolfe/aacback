# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dakota = User.create(username: "dakota", password: "password", first_name: "Dakota", last_name: "Lillie")
lauren = User.create(username: "lauren", password: "password", first_name: "Lauren", last_name: "Settembrino")

c1 = Conversation.create(title: "First Conversation")
c2 = Conversation.create(title: "Second Conversation")

uc1 = UserConversation.create(user_id: dakota.id, conversation_id: c1.id)
uc2 = UserConversation.create(user_id: lauren.id, conversation_id: c1.id)
uc3 = UserConversation.create(user_id: dakota.id, conversation_id: c2.id)
uc4 = UserConversation.create(user_id: lauren.id, conversation_id: c2.id)

uc1.created_at = 5.minutes.ago
uc1.save
uc2.created_at = 5.minutes.ago
uc2.updated_at = 2.minutes.ago
uc2.save
uc3.created_at = 5.minutes.ago
uc3.updated_at = 2.minutes.ago
uc3.save
uc4.created_at = 5.minutes.ago
uc4.save

m1 = Message.create(text: "Hello World!", user_id: dakota.id, conversation_id: c1.id)
m2 = Message.create(text: "Hi Dakota! I love you!", user_id: lauren.id, conversation_id: c1.id)
m3 = Message.create(text: "Hi Lauren! I love you MOAR", user_id: dakota.id, conversation_id: c1.id)
m4 = Message.create(text: "Stop lying, no you don't!", user_id: lauren.id, conversation_id: c1.id)
m5 = Message.create(text: "Happy birthday!", user_id: dakota.id, conversation_id: c1.id)

m1.created_at = 5.minutes.ago
m1.save
m2.created_at = 4.minutes.ago
m2.save
m3.created_at = 3.minutes.ago
m3.save
m4.created_at = 2.minutes.ago
m4.save
m5.created_at = 1.minutes.ago
m5.save

m6 = Message.create(text: "Sup, boo?", user_id: dakota.id, conversation_id: c2.id)
m7 = Message.create(text: "Not much, ghost", user_id: lauren.id, conversation_id: c2.id)
m8 = Message.create(text: "Clever girl <3", user_id: dakota.id, conversation_id: c2.id)
m9 = Message.create(text: "I love you!", user_id: lauren.id, conversation_id: c2.id)

m6.created_at = 5.minutes.ago
m6.save
m7.created_at = 4.minutes.ago
m7.save
m8.created_at = 3.minutes.ago
m8.save
m9.created_at = 2.minutes.ago
m9.save