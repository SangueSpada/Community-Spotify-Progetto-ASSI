# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # GET|POST /users/auth/spotify/callback
  def spotify
    user = User.from_omniauth(auth)

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
  #  super
  #end

  # GET|POST /users/auth/spotify/callback
  def failure
    super
  end

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
