class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  # お気に入りを登録したい user が、newmicropost を探す
  def create
    @newmicropost = Newmicropost.find(params[:newmicropost_id])
    current_user.favorite(@newmicropost)
    flash[:success] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
    # お気に入り登録アクション実行後、お気に入り登録をおこなった画面に戻す/利便性が良い
  end

  def destroy
    @newmicropost = Newmicropost.find(params[:newmicropost_id])
    current_user.unfavorite(@newmicropost)
    flash[:success] = 'お気に入りの登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
