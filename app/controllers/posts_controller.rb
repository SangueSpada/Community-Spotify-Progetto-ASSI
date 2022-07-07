class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def home
    @posts = Post.all
  end

  def new
    @post = Post.new
    if(params[:community_id] != nil)
      @community = Community.find(params[:community_id])
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post creato con successo."
      redirect_to root_path
    else
      flash[:alert] = "Il post non è stato creato. Riprova."
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
      params.require(:post).permit(:title, :body, :community_id)
    end
end
