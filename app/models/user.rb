class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github]
  has_one_attached :icon_image
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
end
