class UsersController < ApplicationController
  def show
    RSpotify.authenticate(Rails.application.credentials[:spotify][:client_id], Rails.application.credentials[:spotify][:client_secret])
    u = User.where(uid: params[:uid]).first
    @user = RSpotify::User.find(u.uid)
    @communities = Community.joins(:participations).where(participations: {user_id: current_user})
    puts "le community sono:"+ String(@communities.count())
    @communities.each do |co|
      puts co.id
    end
    
  end
end
