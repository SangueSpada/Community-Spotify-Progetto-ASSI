class Post < ApplicationRecord
    self.inheritance_column = 'is_community'
    has_many :comments, dependent: :destroy
    has_many :reactions, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true
    validates :author, presence: true
end
