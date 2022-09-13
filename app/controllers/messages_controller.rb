class MessagesController < ApplicationController
    def index
        @messages=Message.all
    end
    def show
        @message=Message.find(params[:id])
    end
    def create
        @message=current_user.messages.create(body: message_params[:body],chat_id: params[:chat_id])
    end
    
    private
    def message_params
        params.require(:message).permit(:body)
    end
end
