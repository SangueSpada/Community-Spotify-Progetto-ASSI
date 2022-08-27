class EventsController < ApplicationController
  before_action :set_event, only: %i[ edit update destroy ]

  # GET /events/new
  def new
    @event = Event.new
    @community = Community.find(params[:community_id])
  end

  # GET /events/1/edit
  def edit
    redirect_to root_path, notice: 'Non puoi accedere a questa sezione!' if current_user != @event.user
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to root_path, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    if (current_user != @event.user && !current_modder)
      redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
    else
      @event.destroy
      
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Event was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :body, :community_id, :user_id)
    end
end
