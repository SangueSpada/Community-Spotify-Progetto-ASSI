class UserReccomendationsController < ApplicationController
  before_action :set_user_reccomendation, only: %i[ show edit update destroy ]

  # POST /user_reccomendations or /user_reccomendations.json
  def create

    user_tags = current_user.tags
    users = User.all

    @rec_users = reccomended_users(user_tags, users)

    @rec_users.each do |user|

      if user != current_user && !user.followers.include?(current_user)

        if user.spotify_hash
          spfy_user = RSpotify::User.new(JSON.parse(user.spotify_hash.gsub('=>', ':').gsub('nil', 'null')))

          @new_recc = UserReccomendation.new(body: 'questo utente', resource_img: spfy_user.images[0]['url'], viewed: false, resource: user, user: current_user)
        else
          @new_recc = UserReccomendation.new(body: 'questo utente', viewed: false, resource: user, user: current_user)
        end

        if @new_recc.save
          puts @new_recc
        end

      end
      
    end

    redirect_to reccomendations_path
  end

  # PATCH/PUT /user_reccomendations/1 or /user_reccomendations/1.json
  def update

    if @user_reccomendation.update(viewed: true)
      redirect_to reccomendations_path
    end

  end

  # DELETE /user_reccomendations/1 or /user_reccomendations/1.json
  def destroy
    @user_reccomendation.destroy

    respond_to do |format|
      format.html { redirect_to user_reccomendations_url, notice: "User reccomendation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_reccomendation
      @user_reccomendation = UserReccomendation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_reccomendation_params
      params.require(:user_reccomendation).permit(:body, :resource_img, :viewed, :resource, :user)
    end

    def reccomended_users(tags, users)

      ret = Array.new
      user_followings = current_user.followings

      users.each do |user|

        same_tags = 0
        followings_in = 0

        usr_tags = user.tags.count

        user_followings.each do |following|
          if user.followers.include?(following)
            followings_in += 1
          end
        end

        tags.each do |tag|
          if user.tags.include?(tag)
            same_tags += 1
          end
        end

        if followings_in >= 3
          if same_tags.to_f/usr_tags >= 0.4
            ret.push(user)
          end
        elsif followings_in > 1 && followings_in < 3
          if same_tags.to_f/usr_tags >= 0.5
            ret.push(user)
          end
        elsif followings_in == 1
          if same_tags.to_f/usr_tags >= 0.6
            ret.push(user)
          end
        else
          if same_tags.to_f/usr_tags >= 0.9
            ret.push(user)
          end
        end

        if ret.length == 3
          return ret
        end

      end

      return ret
    end
end
