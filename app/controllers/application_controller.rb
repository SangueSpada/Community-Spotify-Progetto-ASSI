class ApplicationController < ActionController::Base
    include Pagy::Backend
    before_action :turbo_frame_request_variant
    protect_from_forgery with: :exception
    devise_group :person, contains: [:user, :modder]
    RSpotify.authenticate(Rails.application.credentials[:spotify][:client_id], Rails.application.credentials[:spotify][:client_secret])
    private
    def turbo_frame_request_variant
        request.variant = :turbo_frame if turbo_frame_request?
    end
end
