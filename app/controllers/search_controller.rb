require 'json'

class SearchController < ApplicationController
  def searchbar
    if params[:name_search].present?
      @communities = Community.where('name LIKE ?', "%#{params[:name_search]}%")
      @users = User.where('uid LIKE ?', "%#{params[:name_search]}%")
    else
      @communities = []
      @users = []
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "search/search_results", locals: {communities: @communities, users: @users})
      end
    end
  end

  def spotify
    if params[:name_search].present?
      @artists = RSpotify::Artist.search("%#{params[:name_search]}%", limit: 5, market: 'IT')
      @albums = RSpotify::Album.search("%#{params[:name_search]}%", limit: 5, market: 'IT')
      @playlists = RSpotify::Playlist.search("%#{params[:name_search]}%", limit: 5)
      @songs = RSpotify::Track.search("%#{params[:name_search]}%", limit: 5, market: 'IT')
    else
      @albums = []
      @artists = []
      @playlists = []
      @songs = []
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("spotify_results", partial: "search/spotify_results", locals: {artists: @artists, albums: @albums, playlists: @playlists, songs: @songs})
      end
    end
  
  end

end
