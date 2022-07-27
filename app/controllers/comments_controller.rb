class CommentsController < ApplicationController
    before_action :authenticate_person!
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user = current_user
        if @comment.save
            puts @comment
            if @post.community_id != nil
                @community = Community.find(@post.community_id)
                flash[:notice] = "Commento creato con successo."
                redirect_to community_path(@community)
            else
                flash[:notice] = "Commento creato con successo."
                redirect_to root_path
            end
        else
            if @post.community_id != nil
                @community = Community.find(@post.community_id)
                flash[:alert] = "Il commento non è stato creato. Riprova."
                redirect_to community_path(@community)
            else
                flash[:alert] = "Il commento non è stato creato. Riprova."
                redirect_to root_path
            end
        end
    end

    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        respond_to do |format|
            if @post.community_id != nil
                @community = Community.find(@post.community_id)
                if @comment.update(comment_params)
                    format.html { redirect_to community_url(@community), notice: "Il commento è stato aggiornato con successo."}
                else
                    format.html { redirect_to community_url(@community), alert: "Il commento non è stato aggiornato. Riprova."}
                end
            else
                if @comment.update(comment_params)
                    format.html { redirect_to root_url, notice: "Il commento è stato aggiornato con successo."}
                else
                    format.html { redirect_to root_url, alert: "Il commento non è stato aggiornato. Riprova."}
                end
            end
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if (current_user == @comment.user || current_modder)
            @comment.destroy
        
            if @post.community_id != nil
                @community = Community.find(@post.community_id)
                redirect_to community_path(@community)
            else
                redirect_to root_path
            end
        end    
    end

    private
        def comment_params
            params.require(:comment).permit(:body)
        end
end
