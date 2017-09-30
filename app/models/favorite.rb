class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :newmicropost
  
  validates :user_id, presence: true
  validates :newmicropost_id, presence: true
end
