require 'json'
class UsersController < ApplicationController
  before_action :authenticate_person!, :set_user, only: %i[show edit update]
  def show
    @u = User.where(uid: params[:uid]).first
    @communities = Community.joins(:participations).where(participations: { user_id: @u })
    #puts "le community sono:"+ String(@communities.count())
    @posts = @u.posts.order(created_at: :desc) if @u.posts
    @communities.each do |co|
      #puts co.id
    end
    if @u.spotify_hash
      @user = RSpotify::User.new(JSON.parse(@u.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
      # @user = RSpotify::User.find(@u.uid)
      @top_artist = @user.top_artists.first
      @top_tracks = @user.top_tracks(limit: 5)
      @player = @user.player
      begin
        @player.currently_playing
      rescue NoMethodError
        @currently_playing = nil
      else
        @currently_playing = @player.currently_playing
      end
    else
      @user = nil
    end
  end

  def follow
    if params[:recc_id]
      id = params[:recc_id]
      recc = UserReccomendation.find(id)

      puts 'Reccomendations eliminata' if recc.destroy

    end

    @user = User.where(uid: params[:uid]).first
    if current_user.spotify_hash
      spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
      spotify_user.follow(RSpotify::User.find(@user.uid))
    end
    current_user.followings << @user
    redirect_back(fallback_location: { action: 'show', uid: @user.uid })
  end

  def unfollow
    @user = User.where(uid: params[:uid]).first
    if current_user.spotify_hash
      spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
      spotify_user.unfollow(RSpotify::User.find(@user.uid))
    end
    current_user.given_follows.find_by(followed_user_id: @user.id).destroy
    redirect_back(fallback_location: { action: 'show', uid: @user.uid })
  end

  def edit
    redirect_to root_path, notice: 'Non puoi modificare i tag di un altro utente!' if current_user.uid != params[:uid]
    @tags = Tag.all
  end

  def update
    @user = User.where(id: params[:id]).first
    give_user_tags(@user, params[:user][:tag_ids])
    redirect_to action: 'show', uid: @user.uid
  end

  def user_params
    params.require(:community).permit(:name, :description, :playlist, tag_ids: [])
  end

  def set_user
    @user = User.where(uid: params[:uid]).first
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def give_user_tags(user, tags)
    user.taggableUsers.destroy_all
    tags.each do |tag|
      user.tags << Tag.find(tag) if tag != ''
    end
  end
end
