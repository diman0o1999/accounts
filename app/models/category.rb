class Category < ApplicationRecord

  enum type_of: {
      article: 0,
      report:  1
  }


  has_many :articles_categories, dependent: :destroy


end

