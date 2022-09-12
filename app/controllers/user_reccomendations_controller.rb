class UserReccomendationsController < ApplicationController
  before_action :set_user_reccomendation, only: %i[ show edit update destroy ]

  # POST /user_reccomendations or /user_reccomendations.json
  def create

    user_tags = current_user.tags

    puts "Tag dell'utente"
    user_tags.each do |tag|
      puts tag.name
    end

    users = User.all

    puts "Utenti nel database"
    users.each do |usr|
      puts usr.name
    end

    @rec_users = reccomended_users(user_tags, users)

    @rec_users.each do |user|

      if user != current_user && !user.followers.include?(current_user)
        
        @new_recc = UserReccomendation.new(body: 'questo utente', viewed: false, resource: user, user: current_user)

        if @new_recc.save
          puts"Ci sono degli utenti che non sono stati consigliati"
          puts @new_recc
        end

      end
      
    end

    redirect_to reccomendations_path
  end

  # PATCH/PUT /user_reccomendations/1 or /user_reccomendations/1.json
  def update

    puts "Sono dentro update"

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

      users.each do |user|

        puts user.tags

        counter = 0

        cur_usr_tags = tags.count

        tags.each do |tag|

          if user.tags.include?(tag)
            counter+=1
          end

        end

        puts counter.to_f/cur_usr_tags

        if counter.to_f/cur_usr_tags >= 0.6
          ret.push(user)
        end

        if ret.length == 3
          return ret
        end

      end

      return ret
    end
end
