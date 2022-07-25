class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user
    validates :body, presence: true

    after_create_commit { broadcast_append_to chat}
    def message_time
        created_at.strftime("%d/%m/%y at ")
    end
end
