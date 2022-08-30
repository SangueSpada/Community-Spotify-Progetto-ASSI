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

  #Sezione adibita alla gestione delle interazioni con Google Calendar

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to root_path
  end

  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists

  rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end

  def new_googlecalendar_event
    
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event = Event.find(params[:id])

    event_id = @event.id.to_s + "assi"
    event_date = @event.start_date
    event_title = @event.title

    event = {
      id: event_id,
      summary: event_title,
      start: {
        date: event_date
      },
      end: {
        date: event_date + 1
      }
    }

    puts event[:id]

    service.insert_event('primary', event)

    redirect_to root_path

  rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end

  def delete_googlecalendar_event
    
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event = Event.find(params[:id])

    event_id = @event.id.to_s + "assi"

    @event_list = service.list_events('primary')

    @event_list.items.each do |event|
      if event.id == event_id
        service.delete_event('primary', event.id)
      end
    end

    redirect_to root_path

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
      params.require(:event).permit(:title, :body, :start_date, :start_time, :community_id, :user_id)
    end

    #Crea la struttura con i dati richiesti per effettuare le chiamate API
    def client_options
      {
        client_id: Rails.application.credentials[:google_client_id],
        client_secret: Rails.application.credentials[:google_client_secret],
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: callback_url
      }
    end
  
end
