class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @newmicropost = current_user.newmicroposts.build  # form_for 用
      @newmicroposts = current_user.feed_newmicroposts.order('created_at DESC').page(params[:page])
      # タイムライン機能///feed_
    end
  end
end

#Controllerのデフォルト機能として、アクションの最後にrender :自身のアクション名を呼び出している
#Controllerのアクションに対応するView (routes.rb  > root to: 'toppages#index')