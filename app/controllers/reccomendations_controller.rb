class ReccomendationsController < ApplicationController
  before_action :set_reccomendation, only: %i[ show edit update destroy ]

  # GET /reccomendations or /reccomendations.json
  def index
    @reccomendations = Reccomendation.all
  end

  # GET /reccomendations/1 or /reccomendations/1.json
  def show
  end

  # GET /reccomendations/new
  def new
    @reccomendation = Reccomendation.new
  end

  # GET /reccomendations/1/edit
  def edit
  end

  # POST /reccomendations or /reccomendations.json
  def create
    @reccomendation = Reccomendation.new(reccomendation_params)

    respond_to do |format|
      if @reccomendation.save
        format.html { redirect_to reccomendation_url(@reccomendation), notice: "Reccomendation was successfully created." }
        format.json { render :show, status: :created, location: @reccomendation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reccomendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reccomendations/1 or /reccomendations/1.json
  def update
    respond_to do |format|
      if @reccomendation.update(reccomendation_params)
        format.html { redirect_to reccomendation_url(@reccomendation), notice: "Reccomendation was successfully updated." }
        format.json { render :show, status: :ok, location: @reccomendation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reccomendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reccomendations/1 or /reccomendations/1.json
  def destroy
    @reccomendation.destroy

    respond_to do |format|
      format.html { redirect_to reccomendations_url, notice: "Reccomendation was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def generate_reccomendations
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reccomendation
      @reccomendation = Reccomendation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reccomendation_params
      params.fetch(:reccomendation, {})
    end
end
