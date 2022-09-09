class CommunityReccomendation < ApplicationRecord
    belongs_to :user
    belongs_to :community

    validates :resource_id, presence: true
end
