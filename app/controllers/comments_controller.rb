class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        if @post.community_id != nil
            @community = Community.find(@post.community_id)
            redirect_to community_path(@community)
        else
            redirect_to root_path
        end
    end

    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.update(comment_params)
        if @post.community_id != nil
            @community = Community.find(params[id: @post.community_id])
            redirect_to community_path(@community)
        else
            redirect_to root_path
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.destroy
        if @post.community_id != nil
            @community = Community.find(params[id: @post.community_id])
            redirect_to community_path(@community)
        else
            redirect_to root_path
        end 
    end

    private
        def comment_params
            params.require(:comment).permit(:author, :body)
        end
end
