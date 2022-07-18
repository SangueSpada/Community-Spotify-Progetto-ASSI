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

Community.create(name: 'Community Fake', creator: 'pincopanco', description: 'blablabla',
                 playlist: 'https://open.spotify.com/playlist/37i9dQZF1DZ06evO44UDS4?si=cb6a8c42fee54a28', tags: [Tag.find(1), Tag.find(12)])
Community.create(name: 'Community Fake 2', creator: 'pincopallino', description: 'blablabla',
                 playlist: 'https://open.spotify.com/playlist/37i9dQZF1DZ06evO44UDS4?si=cb6a8c42fee54a28', tags: [Tag.find(5), Tag.find(11)])
@community = Community.create(name: 'Community True', creator: 'valeriolorito', description: 'blablabla',
                              playlist: 'https://open.spotify.com/playlist/37i9dQZF1DZ06evO44UDS4?si=cb6a8c42fee54a28', tags: [Tag.find(2), Tag.find(10)])
@user = User.where(uid: 'valeriolorito').first
@participation = @community.participations.create(user_id: @user.id, community_id: 3, role: :admin, banned: :false)
@participation.user = @user
@participation.community = @community
