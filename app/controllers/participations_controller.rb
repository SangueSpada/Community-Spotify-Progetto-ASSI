class ParticipationsController < ApplicationController
    before_action :authenticate_user!

    def create
        @community = Community.find(params[:community_id])
        @user = User.find(params[:user_id])
        @participation = @community.participations.create(user_id: @user.id, community_id: @community.id, role: :member, banned: false)
        @participation.community = @community
        @participation.user = @user
        redirect_to community_path(@community)
    end

    def update
        @community = Community.find(params[:community_id])
        @user = User.find(params[:user_id])
        if @community.creator != current_user
            puts "Non puoi accedere a questa sezione!"
            redirect_to root_path, alert: "Non puoi accedere a questa sezione!"
        else
            @participation = @community.participations.where(user_id: @user.id).first
            @participation = @participation.update(participation_params)
            @participation.community = @community
            @participation.user = @user
            redirect_to community_path(@community)
        end
    end

    def destroy
        @community = Community.find(params[:community_id])
        @user = User.find(params[:user_id])
        if current_user.participations.where(community_id: @community.id) == nil
            puts "Non puoi accedere a questa sezione!"
            redirect_to root_path, alert: "Non puoi accedere a questa sezione!"
        else 
            @participation = @community.participations.where(user_id: @user.id).first
            @participation.destroy
            redirect_to community_path(@community)
        end
    end

    def participation_params
        params.require(:participation).permit(:role, :banned)
    end
end
