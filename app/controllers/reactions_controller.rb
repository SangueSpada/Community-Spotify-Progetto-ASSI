class ReactionsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @reaction = @post.reactions.create(reaction_params)
        return false
    end

    def update
        @post = Post.find(params[:post_id])
        @reaction = @post.reactions.update(reaction_params)
        return false
    end

    def destroy
        @post = Post.find(params[:post_id])
        @reaction = @post.reactions.destroy
    end

    private
        def reaction_params
            params.require(:reaction).permit(:uid, :like)
        end
end
