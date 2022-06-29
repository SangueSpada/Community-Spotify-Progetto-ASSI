class Reaction < ApplicationRecord
  belongs_to :post

  validates :uid, presence :true
  validates :like, presence :true

  class CommentReaction < Reaction
    belongs_to :comment
  end
end
