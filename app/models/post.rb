class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :reactions, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    validates :author, presence: true

    class CommunityPost < Post
        belongs_to :community
    end
end
