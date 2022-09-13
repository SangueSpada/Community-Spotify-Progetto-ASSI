require 'rails_helper'

RSpec.describe UserReccomendation, type: :model do
  user = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1");
  resource = User.new(email: "fabio@example.com",password: "password",id:2,uid:"2" );
  it 'has 2 users' do
    recc = UserReccomendation.new(
      user: user,
      resource: resource
    )
    expect(recc).to be_valid
  end
  it 'can not have only the user' do
    recc = UserReccomendation.new(
      user: user,
      resource: nil
    )
    expect(recc).to_not be_valid
  end
  it 'can not have only the target user' do
    recc = UserReccomendation.new(
      user: nil,
      resource: resource
    )
    expect(recc).to_not be_valid
  end
  
  it 'has 2 unique users' do
    recc = UserReccomendation.new(
      user: user,
      resource: user
    )
    expect(recc).to_not be_valid
  end
  it 'has to be unique' do

    recc1 = UserReccomendation.new(
      user: user,
      resource: resource
    )
    recc1.save()
    recc2 = UserReccomendation.new(
      user: user,
      resource: resource
    )
    expect(recc2).to_not be_valid
    recc1.destroy
  end 
  it 'has an expiration date' do
    resource=create(:user, id: 1,uid: '1')
    user=create(:user, id: 2,uid: '2')


    recc1 = UserReccomendation.create(
      user: user,
      resource: resource
    )
    expect(recc1.expiration_datetime).to be_truthy

  end
 
end 

