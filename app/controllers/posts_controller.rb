class PostsController < ApplicationController
  def home
    @posts = Post.all
  end
end
