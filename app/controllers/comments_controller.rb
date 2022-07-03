class CommentsController < ApplicationController
    def create
        if()
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @comment = @community_post.comments.create(comment_params)
            redirect_to community_path, community: @community
        else 
            @comment = @post.comments.create(comment_params)
            redirect_to root_path
        end    
    end

    def update
        @post = Post.find(params[:post_id])
        if(@post == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @comment = @community_post.comments.update(comment_params)
            redirect_to community_path, community: @community
        else 
            @comment = @post.comments.update(comment_params)
            redirect_to root_path
        end   
    end

    def destroy
        @post = Post.find(params[:post_id])
        if(@post == nil)
            @community = Community.find(params[:community_id])
            @community_post = @community.community_posts.find(params[:community_post_id])
            @comment = @community_post.comments.destroy
        else 
            @comment = @post.comments.destroy
        end   
    end

    private
        def comment_params
            params.require(:comment).permit(:author, :body)
        end
end
