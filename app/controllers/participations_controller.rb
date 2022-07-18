class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    @participation = @community.participations.new(user_id: @user.id, community_id: @community.id, role: :member,
                                                   banned: false)
    @participation.community = @community
    @participation.user = @user
    if @participation.save
      redirect_to community_path(@community)
    else
      redirect_to community_path(@community), alert: 'Impossibile ammettere utente'
    end
  end

  def ban
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    @user_participation = @community.participations.where(user_id: current_user.id).first
    if @community.creator != current_user.uid || @user_participation.role == 'moderator'
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, alert: 'Non puoi accedere a questa sezione!'
    else
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :banned, banned: :true)
      redirect_to community_path(@community)
    end
  end

  def unban
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    @user_participation = @community.participations.where(user_id: current_user.id).first
    if @community.creator != current_user.uid || @user_participation.role == 'moderator'
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, alert: 'Non puoi accedere a questa sezione!'
    else
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :member, banned: :false)
      redirect_to community_path(@community)
    end
  end

  def promote
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    if @community.creator != current_user.uid
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, alert: 'Non puoi accedere a questa sezione!'
    else
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :moderator)
      redirect_to community_path(@community)
    end
  end

  def demote
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    if @community.creator != current_user.uid
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, alert: 'Non puoi accedere a questa sezione!'
    else
      @participation = @community.participations.where(user_id: @user.id).first
      @participation = @participation.update(role: :member)
      redirect_to community_path(@community)
    end
  end

  def move
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    if @community.creator != current_user.uid
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, alert: 'Non puoi accedere a questa sezione!'
    else
      @admin_participation = @community.participations.where(role: :admin).first
      @admin_participation = @admin_participation.update(role: :moderator)
      @new_admin_participation = @community.participations.where(user_id: @user.id).first
      @new_admin_participation = @new_admin_participation.update(role: :admin)
      redirect_to community_path(@community)
    end
  end

  def destroy
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    if current_user.participations.where(community_id: @community.id).nil?
      puts 'Non puoi accedere a questa sezione!'
      redirect_to root_path, alert: 'Non puoi accedere a questa sezione!'
    else
      @participation = @community.participations.where(user_id: @user.id).first
      @participation.destroy
      redirect_to community_path(@community)
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:role, :banned)
  end
end
