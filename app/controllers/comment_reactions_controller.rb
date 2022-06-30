class CommentReactionsController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @reaction = @comment.comment_reactions.create(comment_reaction_params)
    return false
  end

  def update
    @comment = Comment.find(params[:comment_id])
    @reaction = @comment.reactions.update(comment_reaction_params)
    return false
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @reaction = @comment.reactions.destroy
  end

  private
    def comment_reaction_params
        params.require(:comment_reaction).permit(:uid, :like)
    end
end
