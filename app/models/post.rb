class Post < ApplicationRecord
    belongs_to :user

    has_many :comments, dependent: :destroy
    has_many :reactions, dependent: :destroy

    validates :spotify_content, presence: true
    validates :body, presence: true
end
