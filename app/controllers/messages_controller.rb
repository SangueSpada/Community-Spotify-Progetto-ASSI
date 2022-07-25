class MessagesController < ApplicationController
    def index
        @messages=Message.all
    end
    def show
        @message=Message.find(params[:id])
    end
    def create
        @message=current_user.messages.create(body: message_params[:body],chat_id: params[:chat_id])
=begin        
    if(@message.save)
            redirect_to chat_messages_path(@chat)
        else
            render :show,  status: :unprocessable_entity
        end 
=end
        puts current_user.messages.to_s
    end
    
    private
    def message_params
        params.require(:message).permit(:body)
    end
end
