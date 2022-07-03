class Reaction < ApplicationRecord
  belongs_to :post
  belongs_to :community_post
end
