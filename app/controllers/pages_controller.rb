class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @posts = Post.all
  end
  def profile
  end
end
