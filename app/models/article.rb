class Article < ApplicationRecord

  belongs_to :user

  has_many :comments,   dependent: :destroy
  has_many :ratings,    dependent: :destroy, as: :ratingable
  has_many :favorites,  dependent: :destroy
  has_many :articles_categories, dependent: :destroy
  has_many :categories, through: :articles_categories

  accepts_nested_attributes_for :articles_categories,
                                allow_destroy: true,
                                reject_if: :all_blank

  mount_uploader :image, ImageUploader

  validates :title,
            :text,
            :ip,
            presence: true

  validates :image, file_size: { less_than_or_equal_to: 2000.kilobytes }

  validates :title, length: { minimum: 5 }

  def has_favorite?(user)
    favorites.find_by(user: user).present?
  end

end

