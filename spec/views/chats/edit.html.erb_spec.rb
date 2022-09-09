require 'rails_helper'

RSpec.describe "chats/edit", type: :view do
=begin 
  before(:each) do
    @chat = assign(:chat, Chat.create!())
  end

  it "renders the edit chat form" do
    render

    assert_select "form[action=?][method=?]", chat_path(@chat), "post" do
    end
  end 
=end
end
