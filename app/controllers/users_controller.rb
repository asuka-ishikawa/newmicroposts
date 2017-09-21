class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
    @users = User.all.page(params[:page])
    #全ユーザの一覧表示を代入してviewに渡す
    #ページネーション適用のため.page(params[:page])
  end

  def show
   @user = User.find(params[:id])
   @newmicroposts = @user.newmicroposts.order('created_at DESC').page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
      # users#showアクションへ強制的に移動
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
      # users/new.html.erb を表示する
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
