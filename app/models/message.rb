class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user

    validates_presence_of :body, :chat, :user

    def message_time
        created_at.strftime("%d/%m/%y at ")
    end
end
