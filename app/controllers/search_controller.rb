require 'json'

class SearchController < ApplicationController
  def index
    if params[:name_search].present?
      @communities = Community.where('name LIKE ?', "%#{params[:name_search]}%")
      @users = User.where('uid LIKE ?', "%#{params[:name_search]}%")
    else
      @communities = []
      @users = []
    end
    @str="["
    @communities.each do |community|
      @str << '{"label":"'+community.name+'", "category":"COMMUNITIES"},'
    end
    @users.each do |user|
      @str << '{"label":"'+user.uid+'", "category":"USERS"},'
    end

    @c=@str.chop 
    @c<<"]"
    if @c != "]"
      JSON.parse(@c)
    else
      @c={}
    end
    puts @c

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "search/search_results", locals: {communities: @communities, users: @users})
      end
    end
  end
end
