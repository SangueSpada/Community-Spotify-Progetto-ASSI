class CommunityReccomendationsController < ApplicationController
  before_action :set_community_reccomendation, only: %i[ show edit update destroy ]

  # GET /community_reccomendations or /community_reccomendations.json
  def index
    @community_reccomendations = CommunityReccomendation.all
  end

  # GET /community_reccomendations/1 or /community_reccomendations/1.json
  def show
  end

  # GET /community_reccomendations/new
  def new
    @community_reccomendation = CommunityReccomendation.new
  end

  # GET /community_reccomendations/1/edit
  def edit
  end

  # POST /community_reccomendations or /community_reccomendations.json
  def create
    @community_reccomendation = CommunityReccomendation.new(community_reccomendation_params)

    respond_to do |format|
      if @community_reccomendation.save
        format.html { redirect_to community_reccomendation_url(@community_reccomendation), notice: "Community reccomendation was successfully created." }
        format.json { render :show, status: :created, location: @community_reccomendation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @community_reccomendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /community_reccomendations/1 or /community_reccomendations/1.json
  def update
    respond_to do |format|
      if @community_reccomendation.update(community_reccomendation_params)
        format.html { redirect_to community_reccomendation_url(@community_reccomendation), notice: "Community reccomendation was successfully updated." }
        format.json { render :show, status: :ok, location: @community_reccomendation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @community_reccomendation.errors, status: :unprocessable_entity }
      end
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
      params.require(:reccomendation).permit(:body, :resource_id, :resource_img, :viewed, :community_id)
    end
end
