class TagsController < ApplicationController
    before_action :authenticate_user!
    def new
        @tag = Tag.new()
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @tag = Tag.find(params[:id])
    end

    def update
        @tag = Tag.find(params[:id])
        if @tag.update(tag_params)
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @tag = Tag.find(params[:id])
        @tag.destroy

        redirect_to root_path
    end
end
