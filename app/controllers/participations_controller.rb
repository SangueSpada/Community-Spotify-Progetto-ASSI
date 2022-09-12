class ParticipationsController < ApplicationController
  before_action :authenticate_user!, :set_community_and_user

  def create

    if params[:recc_id]
      id = params[:recc_id]
      recc = CommunityReccomendation.find(id)

      if recc.update(viewed: true)
        puts "Reccomendations aggiornata"
      end
      
    end

    @participation = @community.participations.new(user_id: @user.id, community_id: @community.id, role: :member,
                                                   banned: false)
    @participation.community = @community
    @participation.user = @user
    if @participation.save
      redirect_back(fallback_location: community_path(@community))
    else
      redirect_back(fallback_location: community_path(@community), notice: 'Impossibile ammettere utente')
    end
  end

  def ban
    if @user_participation.role == 'moderator' || @user_participation.role == 'admin'
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :banned, banned: :true)
      redirect_to community_path(@community) 
    else
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    end
  end

  def unban
    if @user_participation.role == 'moderator' || @user_participation.role == 'admin'
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :member, banned: :false)
      redirect_to community_path(@community)
    else
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    end
  end

  def promote
    
    if @user_participation.role == 'admin'
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :moderator)
      redirect_to community_path(@community)
    else
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    end
  end

  def demote
    if @user_participation.role == 'admin'
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :member)
      redirect_to community_path(@community)
    else
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    end
  end

  def move
    
    if @user_participation.role == 'admin'
      @admin_participation = @community.participations.where(role: :admin).first
      @admin_participation = @admin_participation.update(role: :moderator)
      @new_admin_participation = @community.participations.where(user_id: @user.id).first
      @new_admin_participation = @new_admin_participation.update(role: :admin)
      redirect_to community_path(@community)
    else
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    end
  end

  def destroy
    if current_user.participations.where(community_id: @community.id).nil?
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    else
      @participation = @community.participations.where(user_id: @user.id).first
      puts @community.participations.where(user_id: @user.id).first
      @participation.destroy
      redirect_to community_path(@community)
    end
  end

  private

  def set_community_and_user
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    @user_participation = @community.participations.where(user_id: current_user.id).first
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def participation_params
    params.require(:participation).permit(:recc_id, :role, :banned)
  end
end
