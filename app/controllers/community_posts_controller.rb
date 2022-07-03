class CommunityPostsController < ApplicationController
    skip_before_action :verify_authenticity_token

  def show
    @community_posts = CommunityPost.all
  end

  def new
    @community = Community.find(params[:community_id])
    @community_post = @community.community_posts.new
    @author = current_user
  end

  def create
    @community = Community.find(params[:community_id])
    @community_post = @community.community_posts.new(community_post_params)
    if @community_post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end 
  end

  def edit
    @community = Community.find(params[:community_id])
    @community_post = @community.community_posts.find(params[:id])
  end

  def update
    @community = Community.find(params[:community_id])
    @community_post = @community.community_posts.find(params[:id])

    if @community_post.update(community_post_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @community = Community.find(params[:community_id])
    @community_post = @community.community_posts.destroy

    redirect_to root_path, status: :see_other
  end
  
  private
    def community_post_params
      params.require(:community_post).permit(:title, :body, :author)
    end
end
