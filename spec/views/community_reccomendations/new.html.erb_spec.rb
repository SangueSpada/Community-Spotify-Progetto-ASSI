require 'rails_helper'

RSpec.describe "community_reccomendations/new", type: :view do
  before(:each) do
    assign(:community_reccomendation, CommunityReccomendation.new())
  end

  it "renders new community_reccomendation form" do
    render

    assert_select "form[action=?][method=?]", community_reccomendations_path, "post" do
    end
  end
end
