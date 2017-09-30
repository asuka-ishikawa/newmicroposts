class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :newmicropost, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :newmicropost_id], unique: true
    end
  end
end
