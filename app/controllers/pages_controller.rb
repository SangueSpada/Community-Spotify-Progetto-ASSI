class PagesController < ApplicationController
before_action :authenticate_person!
  def home
    @posts = Post.all.order(created_at: :desc)
    @communities = Community.all
    
  end

  def reccomendations
    @community_reccomendations = CommunityReccomendation.all.order(created_at: :desc)
    @user_reccomendations = UserReccomendation.all.order(created_at: :desc)
  end

end
