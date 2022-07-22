class ChatsController < ApplicationController
  before_action :authenticate_user!,:set_chat, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token


  def index
    @chats = Chat.all
  end
  def show
    @chat = Chat.find(params[:uid])
  end
  def new
    @chat = Chat.new
    
  end
  def destroy
    @chat.destroy
    redirect_to root_path
  end

  
  def create
    if check?
      
      @chat = Chat.new
      @chat.user2 = User.find(chat_params[:user2_id])
      @chat.user1 = current_user
      if(@chat.save)
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
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
    print "porco dioooooooooooooo "+@chat.id.to_s+"\n"
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, notice: e.message
  end

  def check?
    if params[:chat][:user2_id] == ""
      return false
    end
    if current_user.id.to_s == params[:chat][:user2_id]
      return false
    end
    if Chat.between(current_user.id,params[:chat][:user2_id]).present?
      return false
    end
    return true
  end  


end
