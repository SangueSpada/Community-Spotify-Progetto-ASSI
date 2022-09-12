class Chat < ApplicationRecord
    belongs_to :user1, class_name: 'User'
    belongs_to :user2, class_name: 'User'

    has_many :messages, dependent: :destroy

    validates_uniqueness_of :user1, :scope => [:user2]
    
    validate do |chat|
        if !user1 || !user2
            if !user1
                errors.add(:user1, "can't be blank")
            end
            if !user2
                errors.add(:user2, "can't be blank")
            end
        elsif user1 == user2
            errors.add(:users, "can't be same user twice")
        elsif Chat.between(user1.id,user2.id).present?
            errors.add(:chat, "already exist in opposite form")
        end
    end

    scope :between, ->(user1,user2) {
            where ("user2_id = "+user1.to_s+" AND user1_id ="+ user2.to_s ) 
        }

end
