class Tag < ApplicationRecord
  has_many :taggableCommunities, dependent: :destroy
  has_many :communities, through: :taggableCommunities
  has_many :taggableUsers, dependent: :destroy
  has_many :users, through: :taggableUsers
end
