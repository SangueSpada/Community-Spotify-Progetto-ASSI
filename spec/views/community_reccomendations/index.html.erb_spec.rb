require 'rails_helper'

RSpec.describe "/reccomendations", type: :view do
  current_user = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1");
  before do
    sign_in current_user
  end
  Tag.create(name: 'Rock')
  Tag.create(name: 'Pop')
  Tag.create(name: 'Metal')
  TaggableUser.create(user_id: 1, tag_id: 1)
  TaggableUser.create(user_id: 1, tag_id: 2)
  TaggableUser.create(user_id: 1, tag_id: 3)

  Community.create(name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "https://open.spotify.com/playlist/1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
  Community.create(name: "COCK", creator: "Pluto", description: "BBBBBBBBBBBBBBBB", playlist: "https://open.spotify.com/playlist/00fyBjjIZWbUya1sg9n9FI?si=2dd08635ebc249c7")
  Community.create(name: "BRO", creator: "Paperino", description: "CCCCCCCCCCCCCCCC", playlist: "https://open.spotify.com/playlist/3Efd5k4pAbgcr9Phd3GkcM?si=fdbddb4f01364f41")

  TaggableCommunity.create(community_id: 1, tag_id: 1)
  TaggableCommunity.create(community_id: 1, tag_id: 2)
  TaggableCommunity.create(community_id: 2, tag_id: 1)
  TaggableCommunity.create(community_id: 2, tag_id: 2)
  TaggableCommunity.create(community_id: 3, tag_id: 1)
  TaggableCommunity.create(community_id: 3, tag_id: 2)
  before(:each) do
    @community_reccomendation=assign(:community_reccomendations, [
      CommunityReccomendation.create(body: 'questa community', resource_id: 1, community_id: 1, user_id:1),
      CommunityReccomendation.create(body: 'questa community', resource_id: 2, community_id: 2, user_id:1),
      CommunityReccomendation.create(body: 'questa community', resource_id: 3, community_id: 3, user_id:1)
    ])
  end

  it "renders a list of community_reccomendations" do
    render
  end 
end
