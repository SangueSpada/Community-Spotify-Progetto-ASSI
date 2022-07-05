class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  has_many :comment_reactions, dependent: :destroy

  validates :body, presence: true
end
