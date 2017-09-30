class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }
      # 外部キーとして参照すべきテーブルを指定 デフォルトのテーブル以外を指定する場合

      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true
      # 重複フォローを許さない
    end
  end
end
