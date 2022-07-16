class CommunitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @communities = if params[:query].present?
                     Community.where('title LIKE ?', "#{params[:query]}%")
                   else
                     Community.all
                   end
  end

  def show
    @community = Community.find(params[:id])
    @user_participation = @community.participations.where(user_id: current_user.id).first
    @posts = @community.posts.all.order(created_at: :desc)
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params.except(:tag_ids))
    give_community_tags(@community, params[:community][:tag_ids])
    if is_a_playlist?(@community.playlist)
      if @community.save
        @community.creator = current_user
        @participation = @community.participations.new(user_id: current_user.id, community_id: @community.id,
                                                       role: :admin, banned: false)
        if @participation.save
          flash[:notice] = 'Community creata con successo.'
          redirect_to community_path(@community)
        else
          flash[:alert] = 'La community non è stata creata. Riprova.'
          render :new, status: :unprocessable_entity
        end
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tags = Tag.all
    @community = Community.find(params[:id])
  end

  def update
    @community = Community.find(params[:id])
    give_community_tags(@community, params[:community][:tag_ids])
    if @community.update(community_params.except(:tag_ids))
      redirect_to community_path(@community)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def the_class_exists?(class_name)
    klass = Module.const_get(class_name)
    klass.is_a?(Class)
  rescue TypeError
    false
  end

  def community_params
    params.require(:community).permit(:name, :description, :playlist, tag_ids: [])
  end

  def give_community_tags(community, tags)
    community.taggables.destroy_all
    tags.to_a.each do |tag|
      community.tags << Tag.find(tag)
    end
  end

  def is_a_playlist?(link)
    !!link.match(%r{https://open.spotify.com/playlist/\w})
  end
end
