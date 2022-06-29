class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    puts current_user
    @posts = Post.all
  end

end
