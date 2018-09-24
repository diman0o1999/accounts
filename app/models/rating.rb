class Rating < ApplicationRecord

  belongs_to :ratingable, required: true, polymorphic: true
  belongs_to :user,       required: true

  validates :mark,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5},
            presence: true

end
