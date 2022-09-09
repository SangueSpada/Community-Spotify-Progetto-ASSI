require 'rails_helper'

RSpec.describe "user_reccomendations/edit", type: :view do
  before(:each) do
    @user_reccomendation = assign(:user_reccomendation, UserReccomendation.create!())
  end

  it "renders the edit user_reccomendation form" do
    render

    assert_select "form[action=?][method=?]", user_reccomendation_path(@user_reccomendation), "post" do
    end
  end
end
