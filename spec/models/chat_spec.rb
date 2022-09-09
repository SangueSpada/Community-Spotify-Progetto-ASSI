require 'rails_helper'

RSpec.describe Chat, type: :model do
  user1 = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1");
  user2 = User.new(email: "fabio@example.com",password: "password",id:2,uid:"2" );
  it 'has 2 users' do
    chat = Chat.new(
      user1: user1,
      user2: user2
    )
    expect(chat).to be_valid
  end
  it 'can not have only 1 user' do
    chat = Chat.new(
      user1: user1,
      user2: nil
    )
    expect(chat).to_not be_valid
  end
  it 'can not have no user' do
    chat = Chat.new(
      user1: nil,
      user2: nil
    )
    expect(chat).to_not be_valid
  end
  
  it 'has 2 unique users' do
    chat = Chat.new(
      user1: user1,
      user2: user1
    )
    expect(chat).to_not be_valid
  end
  it 'has to be unique' do

    chat1 = Chat.new(
      user1: user1,
      user2: user2
    )
    chat1.save()
    chat2 = Chat.new(
      user1: user2,
      user2: user1
    )
    expect(chat2).to_not be_valid
  end 


  
end
