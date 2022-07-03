class ReactionsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        if(@post == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @reaction = @community_post.reactions.create(reaction_params)
            redirect_to community_path, community: @community
        else 
            @comment = @post.reactions.create(reaction_params)
            redirect_to root_path
        end  
    end

    def update
        @post = Post.find(params[:post_id])
        if(@post == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @reaction = @community_post.reactions.update(reaction_params)
            redirect_to community_path, community: @community
        else 
            @comment = @post.reactions.update(reaction_params)
            redirect_to root_path
        end  
    end

    def destroy
        @post = Post.find(params[:post_id])
        if(@post == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @reaction = @community_post.reactions.destroy
        else 
            @comment = @post.reactions.destroy
        end 
    end

    private
        def reaction_params
            params.require(:reaction).permit(:uid, :like)
        end
end
