class CommunityReccomendation < ApplicationRecord
    belongs_to :user
    belongs_to :community

    validates_uniqueness_of :user, :scope => [:community]
end
