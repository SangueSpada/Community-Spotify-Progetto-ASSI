class Message < ApplicationRecord
    belongs_to :chat, touch: true
    belongs_to :user
    validates :body, presence: true

    after_create_commit {broadcast_append_to chat}
end
