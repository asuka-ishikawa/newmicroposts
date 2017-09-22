class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  # followは命名規則を変更しているので補足説明
  # followというclassはない。Userクラスを参照する
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
