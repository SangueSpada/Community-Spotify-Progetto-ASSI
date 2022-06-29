class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:spotify]

  has_many :participations, dependent: :destroy
  has_many :communities, through: :participations, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #puts auth
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.email = auth.info.email
      user.avatar_url = auth.info.image
    end
  
  end
end
