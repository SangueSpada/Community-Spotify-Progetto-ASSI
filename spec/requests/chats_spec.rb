require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/chats", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Chat. As you add validations to Chat, be sure to
  # adjust the attributes here as well.
  user1 = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1");
  
  before(:example) do
    user1 = User.first_or_create(email: "daniele@example.com",password: "password",id:1,uid:"1");
    User.create(email: "fabio@example.com",password: "password",id:2,uid:"2" );
    sign_in user1
  end
  let(:valid_attributes) {
    {
      :id => 1,
      :user1=> user1,
      :user2_id=> 2
    }
  }
  let(:valid_attributes_backwards) {
    {
      :id => 1,
      :user1_id=> 2,
      :user2=> user1
    }
  }

  let(:invalid_attributes) {
    {
      :id => 'a',
      :user1=> user1,
      :user2=> user1
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      get chats_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      chat=Chat.create(valid_attributes)
      get chat_url(chat)
      expect(response).to be_successful
    end
  end


  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Chat" do
        expect {
          post chats_url, params: { user2_id: valid_attributes[:user2_id]}
        }.to change(Chat, :count).by(1)
      end
      it "redirects to the created chat" do
        post chats_url, params: { user2_id: valid_attributes[:user2_id] }
        expect(response).to redirect_to(chat_url(Chat.last))
      end
    end
    context "with valid parameters of already existing chat" do
      it "doesn't create a new Chat" do
        Chat.create(valid_attributes_backwards)
        expect {
          post chats_url, params: { user2_id: valid_attributes[:user2_id] }
        }.to change(Chat, :count).by(0)
      end

      it "redirects to the created chat also if the chat exist backwards" do
        chat=Chat.create(valid_attributes_backwards)
        post chats_url, params: { user2_id: valid_attributes[:user2_id] }
        expect(response).to redirect_to(chat_url(chat.id))
      end
    end
    
    context "with invalid parameters" do
      it "does not create a new Chat" do
        expect {
          post chats_url, params: { user2_id: invalid_attributes[:user2].id }
        }.to change(Chat, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post chats_url, params: { user2_id: invalid_attributes[:user2].id }
        expect(response).to redirect_to(root_path)
      end
    end
  end


  describe "DELETE /destroy" do
    it "destroys the requested chat" do
      chat = Chat.create! valid_attributes
      expect {
        delete chat_url(chat)
      }.to change(Chat, :count).by(-1)
    end

    it "redirects to the chats list" do
      chat = Chat.create! valid_attributes
      delete chat_url(chat)
      expect(response).to redirect_to(chat_path)
    end
  end
end
