class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :articles,   dependent: :destroy
  has_many :ratings,    dependent: :destroy, as: :ratingable
  has_many :favorites,  dependent: :destroy
  has_many :my_favorites_articles, through: :favorites, source: :article, foreign_key: :article_id

  mount_uploader :image, AvatarUploader

  validates :image, file_size: { less_than_or_equal_to: 2000.kilobytes }

  validates :nickname, presence: true, uniqueness: true

end
