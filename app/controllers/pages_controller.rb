class PagesController < ApplicationController
  before_action :authenticate_person!

  def home
    @posts = Post.all.order(created_at: :desc)

    @communities = Community.all
  end

  def reccomendations
    @comm_reccs = CommunityReccomendation.where(user: current_user)

    @comm_reccs.each do |comm_recc|
      #puts comm_recc.expiration_datetime
      #puts DateTime.now
      comm_recc.destroy if comm_recc.expiration_datetime < DateTime.now && comm_recc.viewed == true
    end

    @usr_reccs = UserReccomendation.where(user: current_user)

    @usr_reccs.each do |usr_recc|
      #puts usr_recc.expiration_datetime
      #puts DateTime.now
      usr_recc.destroy if usr_recc.expiration_datetime < DateTime.now && usr_recc.viewed == true
    end

    @community_reccomendations = CommunityReccomendation.where(user: current_user).order(created_at: :desc)
    @user_reccomendations = UserReccomendation.where(user: current_user).order(created_at: :desc)
  end
end
