class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
    end

    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.update(comment_params)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.destroy
    end

    private
        def comment_params
            params.require(:comment).permit(:author, :body)
        end
end
