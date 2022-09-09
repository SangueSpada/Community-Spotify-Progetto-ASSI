class ChatsController < ApplicationController
  before_action :authenticate_user!,:set_chat, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token


  def index
    @chats = Chat.all
  end
  
  def show
    @chat = Chat.find(params[:id])
    @message= Message.new
    pagy_messages=  @chat.messages.order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages,items: 20)
    @messages = messages.reverse
  end

  def new
    @chat = Chat.new
    
  end
  def destroy 
    @chat.destroy
    redirect_to chat_path
  end

  
  def create
    @chat = Chat.new
    if check?
      @chat.user2 = User.find(params[:user2_id])
      @chat.user1 = current_user
      if(@chat.save)
        redirect_to chat_path(@chat)
      else
        @chat=Chat.where(user2_id: params[:user2_id],user1_id: current_user.id).first
        redirect_to chat_path(@chat)
      end
    elsif Chat.between(current_user.id,params[:user2_id]).present?
      @chat = Chat.between(current_user.id,params[:user2_id]).first
      redirect_to chat_path(@chat)
    else
      #redirect_back(fallback_location: root_path) 
      redirect_to root_path
    end
=begin    chat_messages_path(@chat)  
=end

  end

private
  def chat_params
    params.require(:chat).permit(:user2_id)
  end

  def set_chat
    @chat = Chat.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def check?
    if params[:user2_id] == ""
      return false
    end 
    if current_user.id.to_s == params[:user2_id]
      return false
    end
    if Chat.between(current_user.id,params[:user2_id]).present?
      return false
    end
    return true
  end  


end
