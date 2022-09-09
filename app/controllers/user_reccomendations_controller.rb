class UserReccomendationsController < ApplicationController
  before_action :set_user_reccomendation, only: %i[ show edit update destroy ]

  # GET /user_reccomendations or /user_reccomendations.json
  def index
    @user_reccomendations = UserReccomendation.all
  end

  # GET /user_reccomendations/1 or /user_reccomendations/1.json
  def show
  end

  # GET /user_reccomendations/new
  def new
    @user_reccomendation = UserReccomendation.new
  end

  # GET /user_reccomendations/1/edit
  def edit
  end

  # POST /user_reccomendations or /user_reccomendations.json
  def create
    @user_reccomendation = UserReccomendation.new(user_reccomendation_params)

    respond_to do |format|
      if @user_reccomendation.save
        format.html { redirect_to user_reccomendation_url(@user_reccomendation), notice: "User reccomendation was successfully created." }
        format.json { render :show, status: :created, location: @user_reccomendation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_reccomendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_reccomendations/1 or /user_reccomendations/1.json
  def update
    respond_to do |format|
      if @user_reccomendation.update(user_reccomendation_params)
        format.html { redirect_to user_reccomendation_url(@user_reccomendation), notice: "User reccomendation was successfully updated." }
        format.json { render :show, status: :ok, location: @user_reccomendation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_reccomendation.errors, status: :unprocessable_entity }
      end
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
      params.fetch(:user_reccomendation, {})
    end
end
