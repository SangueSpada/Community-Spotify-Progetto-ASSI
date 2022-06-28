class UsersController < ApplicationController
  def show
    @users = User.where(uid: params[:uid])
  end
end
