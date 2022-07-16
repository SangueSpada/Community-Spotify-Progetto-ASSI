class Participation < ApplicationRecord
  enum role: %i[member moderator admin banned]
  after_initialize :set_default_role, if: :new_record?
  def set_default_role
    self.role ||= :user
  end
  belongs_to :community
  belongs_to :user
end
