class Chat < ApplicationRecord
    belongs_to :user1, :foreign_key => :user1 , class_name: 'User'
    belongs_to :user2, :foreign_key => :user2 , class_name: 'User'

    has_many :messagges, dependent: :destroy
    validates_uniqueness_of :user1, :scope => [:user2]

    scope :between, ->(user1,user2) {
            where ("(chats.user1 = ? AND chats.user2 = ?) OR (chats.user2 = ? AND chats.user1 = ?)") 
        }

end
