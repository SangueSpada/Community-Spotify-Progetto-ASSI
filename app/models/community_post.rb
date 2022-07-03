class CommunityPost < ApplicationRecord
    belongs_to :community

    has_many :comments, dependent: :destroy
    has_many :reactions, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    validates :author, presence: true
end