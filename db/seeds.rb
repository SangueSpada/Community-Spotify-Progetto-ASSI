# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Tag.create(name: 'Rock')
Tag.create(name: 'Pop')
Tag.create(name: 'Metal')
Tag.create(name: 'Indie')
Tag.create(name: 'Classica')
Tag.create(name: 'Rap')
Tag.create(name: 'Electro')
Tag.create(name: 'Funk')
Tag.create(name: 'Dance')
Tag.create(name: 'Chill')
Tag.create(name: 'Alternative')
Tag.create(name: 'Sperimentale')
Tag.create(name: 'Hardcore')
Tag.create(name: 'Groovy')


Community.create(name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
Community.create(name: "Community2", creator: "Pluto", description: "BBBBBBBBBBBBBBBB", playlist: "00fyBjjIZWbUya1sg9n9FI?si=2dd08635ebc249c7")
Community.create(name: "Community3", creator: "Paperino", description: "CCCCCCCCCCCCCCCC", playlist: "3Efd5k4pAbgcr9Phd3GkcM?si=fdbddb4f01364f41")
Community.create(name: "Community4", creator: "Pluto", description: "BBBBBBBBBBBBBBBB", playlist: "00fyBjjIZWbUya1sg9n9FI?si=2dd08635ebc249c7")
Community.create(name: "Community5", creator: "Paperino", description: "CCCCCCCCCCCCCCCC", playlist: "3Efd5k4pAbgcr9Phd3GkcM?si=fdbddb4f01364f41")
Community.create(name: "Community6", creator: "Paperino", description: "CCCCCCCCCCCCCCCC", playlist: "3Efd5k4pAbgcr9Phd3GkcM?si=fdbddb4f01364f41") 


TaggableCommunity.create(community_id: 1, tag_id: 6)
TaggableCommunity.create(community_id: 1, tag_id: 10)

TaggableCommunity.create(community_id: 2, tag_id: 1)
TaggableCommunity.create(community_id: 2, tag_id: 2)
TaggableCommunity.create(community_id: 2, tag_id: 3)
TaggableCommunity.create(community_id: 2, tag_id: 6)

TaggableCommunity.create(community_id: 3, tag_id: 1)
TaggableCommunity.create(community_id: 3, tag_id: 2)
TaggableCommunity.create(community_id: 3, tag_id: 3)
TaggableCommunity.create(community_id: 3, tag_id: 6)
TaggableCommunity.create(community_id: 3, tag_id: 7)
TaggableCommunity.create(community_id: 3, tag_id: 10)


User.create(email: "matteo@example.it", uid: 1, password: "password", name: "Matteo")
User.create(email: "marco@example.it", uid: 2, password: "password", name: "Marco")
luca = User.create(email: "luca@example.it", uid: 3, password: "password", name: "Luca")
giovanni=User.create(email: "giovanni@example.it", uid: 4, password: "password", name: "Giovanni")
User.create(email: "leoanrdo@example.it", uid: 5, password: "password", name: "Leonardo")
luca = User.where(name: "Luca").first
Participation.create(user: luca,community_id:6 )
post = Post.create(user: luca, spotify_content: "spotify:track:0ABEVL7pgQLokhBcNJmozw?si=f148e8af5af5425c",community_id: 6, body: "perfetta per la Balestra")
Comment.create(post:post, user:luca,  body: "Si fratello, perfetta per la Balestra")

post = Post.create(user: luca, spotify_content: "spotify:track:0ABEVL7pgQLokhBcNJmozw?si=f148e8af5af5425c",  body: "perfetta per la Balestra")
Comment.create(post:post, user:giovanni,  body: "Si fratello, perfetta per la Balestra")
TaggableUser.create(user_id: 2, tag_id:1)
TaggableUser.create(user_id: 2, tag_id:2)
TaggableUser.create(user_id: 2, tag_id:3)
TaggableUser.create(user_id: 2, tag_id:6)
TaggableUser.create(user_id: 2, tag_id:7)
TaggableUser.create(user_id: 2, tag_id:10)

TaggableUser.create(user_id: 4, tag_id:1)
TaggableUser.create(user_id: 4, tag_id:2)
TaggableUser.create(user_id: 4, tag_id:3)
TaggableUser.create(user_id: 4, tag_id:6)

TaggableUser.create(user_id: 5, tag_id:6)
TaggableUser.create(user_id: 5, tag_id:10)
