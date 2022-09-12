class CommunityReccomendation < ApplicationRecord
    before_create :set_expiration_datetime

    belongs_to :user
    belongs_to :community

    validates_uniqueness_of :user, :scope => [:community]

    def set_expiration_datetime
        self.expiration_datetime =  DateTime.now + 10.seconds
    end
end
