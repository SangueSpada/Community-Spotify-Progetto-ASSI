class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:spotify]

  has_many :participations
  has_many :communities, through: :participations, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow" #FOLLWING_USERS
  # LA GENTE CHE SEGUE L'UTENTE
  has_many :followers, through: :received_follows, source: :follower #FOLLOWERS
  #####################
  # LA GENTE CHE UN UTENTE SEGUE
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow" #FOLLOWED_USERS
  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user #FOLLOWEES


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
