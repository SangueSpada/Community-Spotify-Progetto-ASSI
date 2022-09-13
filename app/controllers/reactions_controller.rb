class ReactionsController < ApplicationController
  before_action :authenticate_user!, :set_reaction, only: %i[update destroy]

  def create
    @post = Post.find(params[:post_id])
    @reaction = @post.reactions.new(reaction_params)
    @reaction.user = current_user
    if @reaction.save
      if !@post.community_id.nil?
        @community = Community.find(@post.community_id)
        redirect_to community_path(@community)
      else
        redirect_to root_path
      end
    else
      redirect_to root_path, alert: 'Impossibile inserire la reaction'
    end
  end

  def update
    @reaction = if @reaction.like == true
                  @reaction.update(like: false)
                else
                  @reaction.update(like: true)
                end
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_to community_path(@community)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @reaction.destroy
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_to community_path(@community)
    else
      redirect_to :back
    end
  end

  private

  def set_reaction
    @post = Post.find(params[:post_id])
    @reaction = @post.reactions.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def reaction_params
    params.require(:reaction).permit(:like)
  end
end
