class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy
  has_many :communities, through: :taggables
end
