class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :favoritings]
  def index
    @users = User.all.page(params[:page])
    #全ユーザの一覧表示を代入してviewに渡す
    #ページネーション適用のため.page(params[:page])
  end

  def show
   @user = User.find(params[:id])
   @newmicroposts = @user.newmicroposts.order('created_at DESC').page(params[:page])
   counts(@user)
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
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favoritings
    @user = User.find(params[:id])
    @favoritings = @user.favoritings.page(params[:page])
    counts(@user)
    # application_controllerの def counts を利用する
  end
    
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end