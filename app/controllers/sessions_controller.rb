class SessionsController < ApplicationController
  # ログイン機能
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      # 下記のprivateで定義している
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    # 存在するか＆emailとpasswordの組み合わせがあっているか確認する
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      # Cookie/Session としてログイン状態が維持される
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
