class Participation < ApplicationRecord
    enum role: [:member, :moderator, :admin]
    after_initialize :set_default_role, :if => :new_record?
    def set_default_role
        self.role ||= :user
    end
end
