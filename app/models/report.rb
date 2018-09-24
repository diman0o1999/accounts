class Report < ApplicationRecord

  belongs_to :category, required: true
  belongs_to :article, required: true
  belongs_to :user, required: true

  validates :category, uniqueness: {scope: [:article, :user]}
end
