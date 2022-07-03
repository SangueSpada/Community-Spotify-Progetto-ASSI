class ReactionsController < ApplicationController
    def create
        if(params[:post_id] == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @reaction = @community_post.reactions.create(reaction_params)
            redirect_to community_path, community: @community
        else 
            @post = Post.find(params[:post_id])
            @comment = @post.reactions.create(reaction_params)
            redirect_to root_path
        end  
    end

    def update
        if(params[:post_id] == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @reaction = @community_post.reactions.update(reaction_params)
            redirect_to community_path, community: @community
        else 
            @post = Post.find(params[:post_id])
            @comment = @post.reactions.update(reaction_params)
            redirect_to root_path
        end  
    end

    def destroy
        if(params[:post_id] == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @reaction = @community_post.reactions.destroy
        else 
            @post = Post.find(params[:post_id])
            @comment = @post.reactions.destroy
        end 
    end

    private
        def reaction_params
            params.require(:reaction).permit(:uid, :like)
        end
end
