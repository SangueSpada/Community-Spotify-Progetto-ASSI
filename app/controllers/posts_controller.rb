class PostsController < ApplicationController
  before_action :authenticate_person!, :set_post, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token

  def home
    @posts = Post.all
  end

  def new
    @post = Post.new
    @community = Community.find(params[:community_id]) unless params[:community_id].nil?
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post creato con successo.'
      redirect_to root_path
    else
      flash[:alert] = 'Il post non è stato creato. Riprova.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to root_path, notice: 'Non puoi accedere a questa sezione!' if current_user != @post.user
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if (current_user != @post.user && !current_modder)
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    else
      @post.destroy
      redirect_to root_path, status: :see_other
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def post_params
    params.require(:post).permit(:title, :body, :community_id)
  end
end
