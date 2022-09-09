require 'rails_helper'

RSpec.describe "community_reccomendations/show", type: :view do
  before(:each) do
    @community_reccomendation = assign(:community_reccomendation, CommunityReccomendation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
