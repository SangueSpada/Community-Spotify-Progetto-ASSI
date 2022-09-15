require 'rails_helper'

RSpec.describe "/user", type: :request do
    user1 = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1");
    before(:example) do
        user1 = User.create(email: "daniele@example.com",password: "password",id:1,uid:"1");
        #User.create(email: "fabio@example.com",password: "password",id:2,uid:"2" );
        sign_in user1
    end
    describe "POST /follow" do
        context "with valid parameters" do
            it "adds the user to the community" do
                user2=create(:user,id:7,uid:"7")
                recc=create(:user_reccomendation, user: user1, resource: user2)
                expect {
                    post  follow_user_path(uid: user2.uid, recc_id: recc.id)
                }.to change(Follow.all, :count).by(1)
            end
            it "deletes the recommendation that let the user know the ccommunity" do
                user2=create(:user,id:7,uid:"7")
                recc=create(:user_reccomendation, user: user1, resource: user2)
                expect {
                    post  follow_user_path(uid: user2.uid, recc_id: recc.id)
                }.to change(UserReccomendation.where(user: user1), :count).by(-1)
            end
        end
    end
end