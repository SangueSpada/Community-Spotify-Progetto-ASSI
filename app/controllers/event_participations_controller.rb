class EventParticipationsController < ApplicationController
    before_action :authenticate_user!
    
    def create

        @event = Event.find(params[:id])
        @user = @event.user
        @community = @event.community
    
        @event_participation = @event.event_participations.new(user: @user, event: @event)

        @event_participation.user = @user
        @event_participation.event = @event

        client = Signet::OAuth2::Client.new(client_options)

        puts "Authorization code: " + client.code.to_s

        client.update!(session[:authorization])

        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client

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

        if @event_participation.save
          redirect_back(fallback_location: community_path(@community))
        else
          redirect_back(fallback_location: community_path(@community), notice: 'Impossibile partecipare all\'evento')
        end

    rescue Google::Apis::AuthorizationError
        response = client.refresh!

        session[:authorization] = session[:authorization].merge(response)

        retry
    end

    def destroy

        @event = Event.find(params[:id])
        @user = @event.user
        @community = @event.community

        client = Signet::OAuth2::Client.new(client_options)

        client.update!(session[:authorization])

        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client

        event_id = @event.id.to_s + "assi"
        event_list = service.list_events('primary')

        event_list.items.each do |event|
            if event.id == event_id
                puts "Trovato evento con l'id che stavi cercando"
                service.delete_event('primary', event.id)
                break
            end
        end

        if current_user.event_participations.where(event: @event).nil?
            redirect_to root_path, notice: 'Non puoi accedere a questa sezione!'
  
        else
            @event_participation = @event.event_participations.where(user: @user).first
            puts @event.event_participations.where(user: @user).first
            @event_participation.destroy
            redirect_to community_path(@community)
        end

    rescue Google::Apis::AuthorizationError
        response = client.refresh!

        session[:authorization] = session[:authorization].merge(response)

        retry
    end

    # Sezione adibita alla gestione delle interazioni con Google Calendar

    def redirect
        puts "Sono dentro redirect"
        client = Signet::OAuth2::Client.new(client_options)

        redirect_to client.authorization_uri.to_s, allow_other_host: true
    end

    def callback
        puts "Sono dentro callback"
        client = Signet::OAuth2::Client.new(client_options)
        client.code = params[:code]

        response = client.fetch_access_token!

        session[:authorization] = response

        redirect_to root_path
    end


    private

    def event_participation_params
        params.require(:event_participation).permit(:user, :event)
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
