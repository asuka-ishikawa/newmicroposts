class ToppagesController < ApplicationController
  def index
  end
end

#Controllerのデフォルト機能として、アクションの最後にrender :自身のアクション名を呼び出している
#Controllerのアクションに対応するView (routes.rb  > root to: 'toppages#index')