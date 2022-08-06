require 'json'
class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @u = User.where(uid: params[:uid]).first
    @communities = Community.joins(:participations).where(participations: {user_id: @u})
    #puts "le community sono:"+ String(@communities.count())
    unless !@u.posts
      @posts = @u.posts.order(created_at: :desc)
    end
    @communities.each do |co|
      #puts co.id
    end
    puts "aoaoaoaoa"+String(@u.spotify_hash)
    @user = RSpotify::User.new(JSON.parse(@u.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
    #@user = RSpotify::User.find(@u.uid)
    @top_artist=@user.top_artists().first
    @top_tracks=@user.top_tracks(:limit => 5)
    @player=@user.player
    begin
      @player.currently_playing
    rescue NoMethodError
      @currently_playing=nil
    else
      @currently_playing=@player.currently_playing
    end
  end
  
  def follow
    @user = User.where(uid: params[:uid]).first
    spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
    spotify_user.follow(RSpotify::User.find(@user.uid))
    current_user.followings << @user
    redirect_back(fallback_location: {action: "show", uid: @user.uid})
  end

  def unfollow
    @user = User.where(uid: params[:uid]).first
    spotify_user = RSpotify::User.new(JSON.parse(current_user.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))
    spotify_user.unfollow(RSpotify::User.find(@user.uid))
    current_user.given_follows.find_by(followed_user_id: @user.id).destroy
    redirect_back(fallback_location: {action: "show", uid: @user.uid})
  end

  def edit
    redirect_to root_path, notice: 'Non puoi modificare i tag di un altro utente!' if current_user.uid != params[:uid]
    @tags = Tag.all
  end
  
  def give_user_tags(user, tags)
    user.taggables.destroy_all
    tags.each do |tag|
      if tag != ""
        community.tags << Tag.find(tag)
      end
    end
  end

end
