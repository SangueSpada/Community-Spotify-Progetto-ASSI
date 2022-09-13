class CommentsController < ApplicationController
  before_action :authenticate_person!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      puts @comment
      if !@post.community_id.nil?
        @community = Community.find(@post.community_id)
        flash[:notice] = 'Commento creato con successo.'
        redirect_back(fallback_location: community_path(@community))
      else
        flash[:notice] = 'Commento creato con successo.'
        redirect_back(fallback_location: root_path)
      end
    elsif !@post.community_id.nil?
      @community = Community.find(@post.community_id)
      flash[:alert] = 'Il commento non è stato creato. Riprova.'
      redirect_back(fallback_location: community_path(@community))
    else
      flash[:alert] = 'Il commento non è stato creato. Riprova.'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if !@post.community_id.nil?
        @community = Community.find(@post.community_id)
        if @comment.update(comment_params)
          format.html do
            redirect_back(fallback_location: community_path(@community),
                          notice: 'Il commento è stato aggiornato con successo.')
          end
        else
          format.html do
            redirect_back(fallback_location: community_path(@community),
                          alert: 'Il commento non è stato aggiornato. Riprova.')
          end
        end
      elsif @comment.update(comment_params)
        format.html do
          redirect_back(fallback_location: root_path, notice: 'Il commento è stato aggiornato con successo.')
        end
      else
        format.html do
          redirect_back(fallback_location: root_path, alert: 'Il commento non è stato aggiornato. Riprova.')
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if current_user == @comment.user || current_modder
      @comment.destroy

      if !@post.community_id.nil?
        @community = Community.find(@post.community_id)
        redirect_back(fallback_location: community_path(@community))
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
