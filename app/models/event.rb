class Event < ApplicationRecord
    belongs_to :community
    belongs_to :user

    validates :title, presence: true
    validates :body, presence: true
end
