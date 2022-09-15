require 'rails_helper'

RSpec.describe "/participation", type: :request do
    user1 = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1");
    before(:example) do
        user1 = User.create(email: "daniele@example.com",password: "password",id:1,uid:"1");
        #User.create(email: "fabio@example.com",password: "password",id:2,uid:"2" );
        sign_in user1
    end
    describe "POST /create" do
        context "with valid parameters" do
            it "adds the user to the community" do
                comm=create(:community,name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
                recc=create(:community_reccomendation, user: user1, community: comm)
                expect {
                    post create_user_community_participation_path(user_id: user1.id,community_id: comm.id,recc_id: recc.id)
                }.to change(Participation.all, :count).by(1)
            end
            it "deletes the recommendation that let the user know the ccommunity" do
                comm=create(:community,name: "NICE", creator: "Pippo", description: "AAAAAAAAAAAAAAAA", playlist: "1mhSPC0EH13KrZrVuB441j?si=13690c7ef7254606")
                recc=create(:community_reccomendation, user: user1, community: comm)
                expect {
                    post create_user_community_participation_path(user_id: user1.id,community_id: comm.id,recc_id: recc.id)
                }.to change(CommunityReccomendation.where(user: user1), :count).by(-1)
            end
        end
    end
end