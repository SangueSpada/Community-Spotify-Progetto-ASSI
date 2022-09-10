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
Community.create(name: "COCK", creator: "Pluto", description: "BBBBBBBBBBBBBBBB", playlist: "00fyBjjIZWbUya1sg9n9FI?si=2dd08635ebc249c7")
Community.create(name: "BRO", creator: "Paperino", description: "CCCCCCCCCCCCCCCC", playlist: "3Efd5k4pAbgcr9Phd3GkcM?si=fdbddb4f01364f41")

TaggableCommunity.create(community_id: 1, tag_id: 6)
TaggableCommunity.create(community_id: 1, tag_id: 10)

TaggableCommunity.create(community_id: 2, tag_id: 1)
TaggableCommunity.create(community_id: 2, tag_id: 2)
TaggableCommunity.create(community_id: 2, tag_id: 3)

TaggableCommunity.create(community_id: 3, tag_id: 4)
TaggableCommunity.create(community_id: 3, tag_id: 6)
TaggableCommunity.create(community_id: 3, tag_id: 10)