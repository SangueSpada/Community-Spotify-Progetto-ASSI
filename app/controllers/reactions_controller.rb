class ReactionsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @reaction = Post.reactions.create(reaction_params)
    end

    def update
        @post = Post.find(params[:post_id])
        @reaction = Post.reactions.update(reaction_params)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @reaction = Post.reactions.destroy
    end

    private
        def reaction_params
            params.require(:reaction).permit(:uid, :like)
        end
end
