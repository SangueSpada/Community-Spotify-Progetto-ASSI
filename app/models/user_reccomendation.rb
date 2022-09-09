class UserReccomendation < ApplicationRecord
    belongs_to :user

    validates :resource_id, presence: true
end
