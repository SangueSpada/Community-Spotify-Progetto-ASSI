class CommentReactionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @comment_reaction = @comment.comment_reactions.create(comment_reaction_params)
    if @post.community_id != nil
        @community = Community.find(@post.community_id)
        redirect_to community_path(@community)
    else
        redirect_to root_path
    end
  end

  def update
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      @comment_reaction = @comment.comment_reactions.find(params[:id])
      if @comment_reaction.like == true
          @reaction = @comment.comment_reactions.update(like: false)
      else
          @reaction = @comment.comment_reactions.update(like: true)
      end
      if @post.community_id != nil
          @community = Community.find(@post.community_id)
          redirect_to community_path(@community)
      else
          redirect_to root_path
      end
  end

  def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      @comment_reaction = @comment.comment_reactions.find(params[:id])
      puts @comment_reaction
      @comment_reaction.destroy
      puts @comment_reaction
      if @post.community_id != nil
          @community = Community.find(@post.community_id)
          redirect_to community_path(@community)
      else
          redirect_to root_path
      end
  end

  private
    def comment_reaction_params
        params.require(:comment_reaction).permit(:uid, :like)
    end
end
