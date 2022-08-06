class TagsController < ApplicationController
  before_action :authenticate_modder!
  def index
    @tags = Tag.all


  end
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; 
    @tag = Tag.find(params[:id])
  end

  def update

    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to tags_path
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
  def set_tag
    @tag = Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end
end
