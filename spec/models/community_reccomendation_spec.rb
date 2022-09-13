require 'rails_helper'

RSpec.describe CommunityReccomendation, type: :model do

  it 'has 1 user and 1 community' do
    comm=create(:community,name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
    user=create(:user, id: 2,uid: '2')

    recc = CommunityReccomendation.new(
      user: user,
      community: comm
    )
    expect(recc).to be_valid
  end
  it 'cant have only the user' do
    user=create(:user, id: 2,uid: '2')

    recc = CommunityReccomendation.new(
      user: user,
      community: nil
    )
    expect(recc).to_not be_valid
  end
  it 'cant have only the community' do
    comm=create(:community,name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")

    recc = CommunityReccomendation.new(
      user: nil,
      community: comm
    )
    expect(recc).to_not be_valid
  end
  it 'has to be unique' do
    comm=create(:community,name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
    user=create(:user, id: 2,uid: '2')


    recc1 = CommunityReccomendation.new(
      user: user,
      community: comm
    )
    recc1.save()
    recc2 = CommunityReccomendation.new(
      user: user,
      community: comm
    )
    expect(recc2).to_not be_valid
    recc1.destroy
  end
  it 'has an expiration date' do
    comm=create(:community,name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
    user=create(:user, id: 2,uid: '2')


    recc1 = CommunityReccomendation.create(
      user: user,
      community: comm
    )
    expect(recc1.expiration_datetime).to be_truthy

  end
end
