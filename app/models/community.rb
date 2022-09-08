class Community < ApplicationRecord
    has_many :participations
    has_many :users, through: :participations, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :events, dependent: :destroy

    has_many :taggableCommunities, dependent: :destroy
    has_many :tags, through: :taggableCommunities

    validates :name, presence: true
    validates :description, presence: true
end
