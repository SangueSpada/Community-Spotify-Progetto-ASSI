class CommentReactionsController < ApplicationController
  before_action :authenticate_user!, :set_comment

  def create
    @comment_reaction = @comment.comment_reactions.new(comment_reaction_params)
    @comment_reaction.user = current_user
    if @comment_reaction.save
      if !@post.community_id.nil?
        @community = Community.find(@post.community_id)
        redirect_back(fallback_location: community_path(@community))
      else
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_to root_path, alert: 'Impossibile inserire la reaction'
    end
  end

  def update
    @comment_reaction = @comment.comment_reactions.find(params[:id])
    @comment_reaction = if @comment_reaction.like == true
                          @comment_reaction.update(like: false)
                        else
                          @comment_reaction.update(like: true)
                        end
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_back(fallback_location: community_path(@community))
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment_reaction = @comment.comment_reactions.find(params[:id])
    @comment_reaction.destroy
    
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_back(fallback_location: community_path(@community))
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def comment_reaction_params
    params.require(:comment_reaction).permit(:like)
  end
end
