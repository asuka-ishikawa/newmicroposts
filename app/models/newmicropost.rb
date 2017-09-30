class Newmicropost < ApplicationRecord
  belongs_to :user
  
  # NewmicropostはたくさんのUserからお気に入り される 可能性あり
  # Favoriteは実在するモデルなので
  has_many :favorites
  has_many :favoritings, through: :favorites, source: :newmicropost
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
