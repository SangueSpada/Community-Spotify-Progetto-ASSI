class Event < ApplicationRecord
    has_many :event_participations
    has_many :users, through: :event_participations, dependent: :destroy
    
    belongs_to :user
    belongs_to :community



    validates :title, presence: true
    validates :body, presence: true
    validates :start_date, presence: true
end
