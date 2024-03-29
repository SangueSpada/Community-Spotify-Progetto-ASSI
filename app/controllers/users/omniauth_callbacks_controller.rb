# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # GET|POST /users/auth/spotify/callback
  def spotify
    user = User.from_omniauth(auth)
    spotify_user=RSpotify::User.new(auth)
    spotify_hash=spotify_user.to_hash
    spotify_hash.delete("images")
    credentials= spotify_hash.fetch("credentials").to_hash
    followers= spotify_hash.fetch("followers").to_hash
    external_urls= spotify_hash.fetch("external_urls").to_hash
    spotify_hash["credentials"]=credentials
    spotify_hash["followers"]=followers
    spotify_hash["external_urls"]=external_urls
    user.spotify_hash=spotify_hash
    user.save
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success',kind: 'Spotify'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure',kind: 'Spotify', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
    
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /users/auth/spotify
  #def passthru
  #end

  # GET|POST /users/auth/spotify/callback
  #def failure
  #  super
  #end

  # protected
  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end


  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
