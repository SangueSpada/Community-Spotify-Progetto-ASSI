class UserReccomendation < ApplicationRecord
    before_create :set_expiration_datetime

    belongs_to :user
    belongs_to :resource, class_name: 'User'

    validates_uniqueness_of :user, :scope => [:resource]

    def set_expiration_datetime
        self.expiration_datetime =  DateTime.now + 10.seconds
    end
end
