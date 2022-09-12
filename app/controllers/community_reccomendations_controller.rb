class CommunityReccomendationsController < ApplicationController
  before_action :set_community_reccomendation, only: %i[ show edit update destroy ]

  # POST /community_reccomendations or /community_reccomendations.json
  def create

    user_tags = current_user.tags

    puts "Tag dell'utente"
    user_tags.each do |tag|
      puts tag.name
    end

    communities = Community.all

    puts "Community nel database"
    communities.each do |comm|
      puts comm.name
    end

    @rec_communities = reccomended_communities(user_tags, communities)

    @rec_communities.each do |community|

      if !community.users.include?(current_user)

        @new_recc = CommunityReccomendation.new(body: 'questa community', viewed: false, community: community, user: current_user)

        if @new_recc.save
          puts"Ci sono delle community che non sono state consigliate"
          puts @new_recc
        end
        
      end
      
    end

    redirect_to reccomendations_path

  end

  # PATCH/PUT /community_reccomendations/1 or /community_reccomendations/1.json
  def update

    puts "Sono dentro update"

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

      communities.each do |community|

        counter = 0

        user_tags = tags.count

        tags.each do |tag|

          if community.tags.include?(tag)
            counter+=1
          end

        end

        puts counter.to_f/user_tags

        if counter.to_f/user_tags >= 0.6
          ret.push(community)
        end

        if ret.length == 3
          return ret
        end

      end

      return ret
    end

end
