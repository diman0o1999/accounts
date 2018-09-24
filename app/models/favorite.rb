class Favorite < ApplicationRecord

  belongs_to :article,  required: true
  belongs_to :user,     required: true

  validates :article, uniqueness: { scope: :user }

end
