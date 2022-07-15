class SearchController < ApplicationController
  def index
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
end
