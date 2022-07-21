class CommentReactionsController < ApplicationController
  before_action :authenticate_user!, :set_comment, only: %i[create update destroy]

  def create
    @comment_reaction = @comment.comment_reactions.create(comment_reaction_params)
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_to community_path(@community)
    else
      redirect_to root_path
    end
  end

  def update
    @comment_reaction = @comment.comment_reactions.find(params[:id])
    @reaction = if @comment_reaction.like == true
                  @comment.comment_reactions.update(like: false)
                else
                  @comment.comment_reactions.update(like: true)
                end
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_to community_path(@community)
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment_reaction = @comment.comment_reactions.find(params[:id])
    puts @comment_reaction
    @comment_reaction.destroy
    puts @comment_reaction
    if !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      redirect_to community_path(@community)
    else
      redirect_to root_path
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
    params.require(:comment_reaction).permit(:uid, :like)
  end
end
