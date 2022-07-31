class PagesController < ApplicationController
before_action :authenticate_person!
  def home
    @posts = Post.all.order(created_at: :desc)
    @communities = Community.all
    
  end

end
