class EventsController < ApplicationController
  before_action :authenticate_user!, :set_event, only: %i[ edit update destroy ]

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
        format.html { redirect_to new_community_event_path(event_params[:community_id]), status: :unprocessable_entity }
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

 
      @event.destroy
      
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Event was successfully destroyed." }
        format.json { head :no_content }
      end

  end

  def new_googlecalendar_event
    
    client = Signet::OAuth2::Client.new(client_options)

    puts "Authorization code: " + client.code.to_s

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event = Event.find(params[:id])

    event_id = @event.id.to_s + "assi"
    event_date = @event.start_date
    event_title = @event.title

    event = service.get_event('primary', event_id)

    if event
      event.status = 'confirmed'
      event.summary = event_title
      event.start.date = event_date
      event.end.date = event_date + 1
      
      service.update_event('primary', event_id, event)
      
    else

      event = {
        id: event_id,
        status: 'confirmed',
        summary: event_title,
        start: {
          date: event_date
        },
        end: {
          date: event_date + 1
        }
      }
  
      puts event
  
      service.insert_event('primary', event)
    end

    return

  rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end

  def delete_googlecalendar_event
    
    client = Signet::OAuth2::Client.new(client_options)

    if !client.code
      redirect_to client.authorization_uri.to_s, allow_other_host: true
    end

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event = Event.find(params[:id])

    event_id = @event.id.to_s + "assi"

    event_list = service.list_events('primary')

    event_list.items.each do |event|
      if event.id == event_id
        puts "Trovato evento con l'id che stavi cercando"
        service.delete_event('primary', event.id)
        break
      end
    end

    return

  rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :body, :start_date, :community_id, :user_id)
    end
  
end
