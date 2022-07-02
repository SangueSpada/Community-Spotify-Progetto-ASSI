class Taggable < ApplicationRecord
  belongs_to :community
  belongs_to :tag
end
