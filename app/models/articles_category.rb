class ArticlesCategory < ApplicationRecord

  belongs_to :category, required: true
  belongs_to :article, required: true

  validates :category, uniqueness: {scope: :article}

end
