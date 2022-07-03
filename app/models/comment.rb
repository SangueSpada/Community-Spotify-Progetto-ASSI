class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :community_post

  has_many :comment_reactions, dependent: :destroy

  validates :body, presence: true
  validates :author, presence: true
end
