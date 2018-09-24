class Comment < ApplicationRecord

  belongs_to :article, required: true,  counter_cache: :comments_count
  belongs_to :user, required: true


  validates :body, presence: true
end
