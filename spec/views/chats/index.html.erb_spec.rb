require 'rails_helper'

RSpec.describe "chats/index", type: :view do
  user1 = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1", name:"daniele" );
  user2 = User.new(email: "fabio@example.com",password: "password",id:2,uid:"2" , name: "fabio");
  user3 = User.new(email: "fabio@example.com",password: "password",id:3,uid:"3", name: "fabio" );
=begin   before do
    sign_in user1
  end 
=end
  before(:each) do
    @chats=assign(:chats, [
      Chat.create!(user1: user1,user2: user2),
      Chat.create!(user1: user3,user2: user1),
      Chat.create!(user1: user3,user2: user2)
    ])
  end    
  it "renders a list of chats" do
    render
    assert_select 'li>div>span', text: 'fabio'.to_s,count:2
    assert_select 'li>div>span', text: 'fabio'.to_s,count:2
  end
end
