class CommunitiesController < ApplicationController
  before_action :authenticate_user!, :set_community, only: %i[show edit update destroy]

  def index
    @communities = if params[:query].present?
                     Community.where('title LIKE ?', "#{params[:query]}%")
                   else
                     Community.all
                   end
  end

  def show
    
    @admin_participation = @community.participations.where(role: 'admin').first
    @playlist = RSpotify::Playlist.find(@admin_participation.user.uid, @community.playlist)
    #@spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
    @posts = @community.posts.all.order(created_at: :desc)
    @events = @community.events.all.order(created_at: :desc)
    if !session[:authorization]
      @client = Signet::OAuth2::Client.new(client_options)
    end
  end

  def new
    @community = Community.new
    @playlist = RSpotify::User.find(current_user.uid).playlists(limit: 50)
  end

  def create
    @playlist = RSpotify::User.find(current_user.uid).playlists(limit: 50)
    @community = Community.new(community_params.except(:tag_ids))
    @community.creator = current_user.uid
    give_community_tags(@community, params[:community][:tag_ids])
    if @community.playlist?
      if @community.save
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
    @playlist = RSpotify::User.find(current_user.uid).playlists(limit: 50)
    if @user_participation.user_id != current_user.id
      redirect_to community_path(@community), notice: 'Non puoi accedere a questa sezione!'
    end
    @tags = Tag.all
  end

  def update
    if @user_participation.user_id != current_user.id
      redirect_to community_path(@community), notice: 'Non puoi accedere a questa sezione!'
    else
      give_community_tags(@community, params[:community][:tag_ids])
      if @community.update(community_params.except(:tag_ids))
        redirect_to community_path(@community)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @user_participation.user_id != current_user.id
      redirect_to community_path(@community), notice: 'Non puoi accedere a questa sezione!'
    else
      @community.destroy
      redirect_to root_path, status: :see_other
    end
  end

  private

  def set_community
    @community = Community.find(params[:id])
    @user_participation = @community.participations.where(user_id: current_user.id).first
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

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
    tags.each do |tag|
      if tag != ""
        community.tags << Tag.find(tag)
      end
    end
  end

  def is_a_playlist?(link)
    !!link.match(%r{https://open.spotify.com/playlist/\w})
  end

  #Crea la struttura con i dati richiesti per effettuare le chiamate API
  def client_options
    {
      client_id: Rails.application.credentials[:google_client_id],
      client_secret: Rails.application.credentials[:google_client_secret],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
