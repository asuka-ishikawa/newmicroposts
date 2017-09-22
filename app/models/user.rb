class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  #パスワード付きのモデル作成時に使用
  #Rails標準機能
  
  has_many :newmicroposts
  # 一対多
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  # followingsはここで命名。followingクラスはないため補足説明
  # relationshipsモデルのfollow_idカラムから、フォローしているUserたちを取得
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
    # もしAさん本人じゃなかったら
      self.relationships.find_or_create_by(follow_id: other_user.id)
      # followの重複を防ぐ
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
    # もしフォローしてたら、アンフォローする
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
    # AさんがフォローしているUserを探す・include?(other_user)Bさんとか他ユーザのものが含まれてないか確認
  end
end
