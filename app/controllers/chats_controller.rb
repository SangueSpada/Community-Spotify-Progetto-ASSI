class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users=User.all
    @chats = Chat.all
  end
  def new
    @chat = Chat.new
  end
  
  
  def create
=begin    if Chat.between(params[:chat][:user1],params[:chat][:user2]).present?
      @chat = Chat.between(params[:chat][:user1],params[:chat][:user2]).first
    else
      @chat = Chat.new(chat_params)   
    end
=end
    @chat = Chat.new(chat_params)
    if(@chat.save)
      redirect_to @chat
    else
      render :new, status: :unprocessable_entity
    end
=begin        chat_messages_path(@chat) 
=end
  end

  private
  def chat_params
    params.require(:chat).permit(:user1,:user2)
  end

end
