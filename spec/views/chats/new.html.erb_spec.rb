require 'rails_helper'
require_relative "../../support/devise"
RSpec.describe "chats/new", type: :view do
  include Devise::Test::IntegrationHelpers
  before(:each) do
    user1 = User.new(email: "daniele@example.com",password: "password",id:1,uid:"1", name:"daniele" );
    sign_in user1
    assign(:chat, Chat.new())
  end

  it "renders new chat form" do
    render

    assert_select "form[action=?][method=?]", chats_path, "post" do
    end
  end 

end
