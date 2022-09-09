require 'rails_helper'

RSpec.describe "community_reccomendations/edit", type: :view do
  before(:each) do
    @community_reccomendation = assign(:community_reccomendation, CommunityReccomendation.create!())
  end

  it "renders the edit community_reccomendation form" do
    render

    assert_select "form[action=?][method=?]", community_reccomendation_path(@community_reccomendation), "post" do
    end
  end
end
