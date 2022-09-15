class CommunityReccomendationsController < ApplicationController
  before_action :set_community_reccomendation, only: %i[ show edit update destroy ]

  # POST /community_reccomendations or /community_reccomendations.json
  def create

    user_tags = current_user.tags
    communities = Community.all

    @rec_communities = reccomended_communities(user_tags, communities)

    @rec_communities.each do |community|

      if !community.users.include?(current_user)

        if community.participations && community.participations.where(role: 'admin').first
          @admin_participation = community.participations.where(role: 'admin').first

          @playlist = RSpotify::Playlist.find(@admin_participation.user.uid, community.playlist)

          if @playlist
            @new_recc = CommunityReccomendation.new(body: 'questa community', resource_img: @playlist.images[0]['url'], viewed: false, community: community, user: current_user)
          end

        else
          @new_recc = CommunityReccomendation.new(body: 'questa community', viewed: false, community: community, user: current_user)
        end

        if @new_recc.save
          puts @new_recc
        end
        
      end
      
    end

    redirect_to reccomendations_path

  end

  # PATCH/PUT /community_reccomendations/1 or /community_reccomendations/1.json
  def update

    if @community_reccomendation.update(viewed: true)
      redirect_to reccomendations_path
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
      params.require(:community_reccomendation).permit(:body, :resource_img, :viewed, :community, :user)
    end

    def reccomended_communities(tags, communities)

      ret = Array.new
      user_followings = current_user.followings

      communities.each do |community|

        same_tags = 0
        followings_in = 0

        comm_tags = community.tags.count

        user_followings.each do |following|
          if community.users.include?(following)
            followings_in += 1
          end
        end

        tags.each do |tag|
          if community.tags.include?(tag)
            same_tags += 1
          end
        end

        if followings_in >= 3
          if same_tags.to_f/comm_tags >= 0.4
            ret.push(community)
          end
        elsif followings_in > 1 && followings_in < 3
          if same_tags.to_f/comm_tags >= 0.5
            ret.push(community)
          end
        elsif followings_in == 1
          if same_tags.to_f/comm_tags >= 0.6
            ret.push(community)
          end
        else
          if same_tags.to_f/comm_tags >= 0.9
            ret.push(community)
          end
        end

        if ret.length == 3
          return ret
        end

      end

      return ret
    end

end
