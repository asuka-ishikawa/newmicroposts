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
  # relationshipsモデルのfollow_idカラム(参照先idはfollowだよ)から、フォローしているUserたちを取得
  # こうすることで、呼び出し側のusers_controllerで user.followings でUserの取得が可能になる(簡単な方法)
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites
  has_many :favoritings, through: :favorites, source: :newmicropost
  # ユーザモデルからみた「お気に入り」の定義
  # データの関連性を表すもの＝アソシエーション（関連）の定義
  
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
  
  def feed_newmicroposts
    Newmicropost.where(user_id: self.following_ids + [self.id])
    # following_ids///has_many :followings, から自動生成
    # self.id///データ型を合わせるため配列にして[self.id]
    # Micropost.where(user_id: フォローユーザ + [自分自身]) となる Micropost を全て取得する
  end
  
  # def favorites_list
  #   Newmicroposts.where(user_id: self.favoriting_ids + [self.id])
  # end
  
  def favorite(newmicropost)
    self.favorites.find_or_create_by(newmicropost_id: newmicropost.id)
  end
  
  def unfavorite(newmicropost)
    favorite = self.favorites.find_by(newmicropost_id: newmicropost.id)
    favorite.destroy if favorite
  end
  # newmicropost_idカラム の newmicropost.id を探す
  # 現状は存在していないものを探すので (newmicropost) という風に引数で渡す
  
  def favoriting?(newmicropost)
    self.favoritings.include?(newmicropost)
  end
  #お気に入りしているnewmicropost達を取得
end
