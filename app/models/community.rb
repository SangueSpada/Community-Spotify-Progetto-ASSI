class Community < ApplicationRecord
    has_and_belongs_to_many :communities, dependent: :destroy
    has_many :participations, dependent: :destroy
    has_many :users, through: :participations, dependent: :destroy
    has_many :community_posts, dependent: :destroy
end
