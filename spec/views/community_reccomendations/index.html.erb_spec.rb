require 'rails_helper'

RSpec.describe "community_reccomendations/index", type: :view do
  before(:each) do
    assign(:community_reccomendations, [
      CommunityReccomendation.create!(),
      CommunityReccomendation.create!()
    ])
  end

  it "renders a list of community_reccomendations" do
    render
  end
end
