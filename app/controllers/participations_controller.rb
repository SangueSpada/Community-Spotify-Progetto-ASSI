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
            redirect_to root_path, alert: "Non puoi accedere a questa sezione!"
        end
        @participation = @community.participations.find(params[:id])
        @participation = @participation.update(participation_params)
        @participation.community = @community
        @participation.user = @user
        redirect_to community_path(@community)
    end

    def destroy
        @community = Community.find(params[:community_id])
        @user = User.find(params[:user_id])
        if @community.creator != current_user || current_user.participations.where(community_id: @community.id).first == nil
            redirect_to root_path, alert: "Non puoi accedere a questa sezione!"
        end
        @participation = @community.participations.find(params[:id])
        @participation.delete
        redirect_to community_path(@community)
    end

    def participation_params
        params.require(:participation).permit(:role, :banned)
    end
end
