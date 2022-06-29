class Tag < ApplicationRecord
  has_and_belongs_to_many :communities, dependent: :destroy
end
