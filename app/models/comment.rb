class Comment < ApplicationRecord
  belongs_to :post

  has_many :reactions, dependent: :destroy

  validates :body, presence: true
  validates :author, presence: true
end
