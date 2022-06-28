class PostsController < ApplicationController
  def home
    @posts = Post.all
  end

  def new
    @post = Post.new
    @authors = User.where(uid: params[:uid])
    @author = User.first
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :body, :author)
    end
end
