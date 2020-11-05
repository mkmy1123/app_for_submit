class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github]
  has_one_attached :icon_image

  has_many :following_relationships, class_name:  "UserRelationship",
                                     foreign_key: "following_id",
                                     dependent:   :destroy
  has_many :followings, through: :following_relationships, source: :followed
  has_many :followed_relationships, class_name:  "UserRelationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :followers, through: :followed_relationships, source: :following

  validates :name, length: { maximum: 20 }
  validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }, allow_blank: true
  validates :address, length: { maximum: 200 }
  validates :introduction, length: { minimum: 5, maximum: 500 }, allow_blank: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.now.utc
    end
  end

  def follow(other_user)
    unless self == other_user
      following_relationships.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy!
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
