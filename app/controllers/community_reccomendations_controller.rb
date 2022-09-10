class CommunityReccomendationsController < ApplicationController
  before_action :set_community_reccomendation, only: %i[ show edit update destroy ]

  # POST /community_reccomendations or /community_reccomendations.json
  def create
    user_tags = current_user.tags

    communities = Community.all

    @rec_communities = reccomended_communities(user_tags, communities)

    @rec_communities.each do |community|

      CommunityReccomendation.create(body: 'questa community', community: community, user: current_user)
      
    end

    redirect_back(fallback_location: reccomendations_path)

  end

  # PATCH/PUT /community_reccomendations/1 or /community_reccomendations/1.json
  def update
    respond_to do |format|
      if @community_reccomendation.update(community_reccomendation_params)
        format.html { redirect_to community_reccomendation_url(@community_reccomendation), notice: "Community reccomendation was successfully updated." }
        format.json { render :show, status: :ok, location: @community_reccomendation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @community_reccomendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_reccomendations/1 or /community_reccomendations/1.json
  def destroy
    @community_reccomendation.destroy

    respond_to do |format|
      format.html { redirect_to community_reccomendations_url, notice: "Community reccomendation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_reccomendation
      @community_reccomendation = CommunityReccomendation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def community_reccomendation_params
      params.require(:reccomendation).permit(:body, :resource_img, :viewed, :community, :user)
    end

    def reccomended_communities(tags, communities)

      ret = Array.new

      communities.each do |community|

        counter = 0

        comm_tags = community.tags.count

        tags.each do |tag|

          if community.tags.include?(tag)
            counter+=1
          end

        end

        if counter/comm_tags >= 0.6
          ret.push(community)
        end

        puts ret.length

        if ret.length == 3
          return ret
        end

      end

      puts ret
      return ret
    end

end
