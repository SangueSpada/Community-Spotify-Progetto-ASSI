class UsersController < ApplicationController
  def show
    RSpotify.authenticate(Rails.application.credentials[:spotify][:client_id], Rails.application.credentials[:spotify][:client_secret])
    u = User.where(uid: params[:uid]).first
    @user = RSpotify::User.find(u.uid)
    puts "il link è"+ @user.images[0]['url']
    
  end
end
