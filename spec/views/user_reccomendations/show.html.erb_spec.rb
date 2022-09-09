require 'rails_helper'

RSpec.describe "user_reccomendations/show", type: :view do
  before(:each) do
    @user_reccomendation = assign(:user_reccomendation, UserReccomendation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
