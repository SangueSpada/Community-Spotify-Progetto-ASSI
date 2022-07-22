class Chat < ApplicationRecord
    belongs_to :user1, class_name: 'User'
    belongs_to :user2, class_name: 'User'

    has_many :messages, dependent: :destroy
    validates_uniqueness_of :user1, :scope => [:user2]

    scope :between, ->(user1,user2) {
            where ("user2_id = "+user1.to_s+" AND user1_id ="+ user2.to_s) 
        }

end
