class ReactionsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @reaction = @post.reactions.create(reaction_params)
        if @post.community_id != nil
            @community = Community.find(@post.community_id)
            redirect_to community_path(@community)
        else
            redirect_to root_path
        end
    end

    def update
        @post = Post.find(params[:post_id])
        @reaction = @post.reactions.find(params[:id])
        if @reaction.like == true
            @reaction = @post.reactions.update(like: false)
        else
            @reaction = @post.reactions.update(like: true)
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
        @reaction = @post.reactions.find(params[:id])
        @reaction.destroy
        if @post.community_id != nil
            @community = Community.find(@post.community_id)
            redirect_to community_path(@community)
        else
            redirect_to root_path
        end
    end

    private
        def reaction_params
            params.require(:reaction).permit(:uid, :like)
        end
end
