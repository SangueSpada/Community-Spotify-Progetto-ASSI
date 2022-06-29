class CommunitiesController < ApplicationController
    def new
        @community = Community.new()
        @creator = User.where(uid: params[:uid]).first
    end

    def create
        @community = Community.new(community_params, creator: @creator)
        if @community.save
            @participation = Participation.new(role: :admin)
            if @participation.save
                redirect_to root_path
            else
                render :new, status: :unprocessable_entity
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @community = Community.find(params[:id])
    end

    def update
        @community = Community.find(params[:id])
        if @community.update(community_params)
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @community = Community.find(params[:id])
        @community.destroy

        redirect_to root_path, status: :see_other
    end

    private
        def community_params
            params.require(:community).permit(:name, :description, :playlist)
        end
end
