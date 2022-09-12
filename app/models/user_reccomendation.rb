class UserReccomendation < ApplicationRecord
    belongs_to :user
    belongs_to :resource, class_name: 'User'

    validates_uniqueness_of :user, :scope => [:resource]
end
