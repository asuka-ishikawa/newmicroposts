class NewmicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @newmicropost = current_user.newmicroposts.build(newmicropost_params)
    if @newmicropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @newmicroposts = current_user.newmicroposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @newmicropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def newmicropost_params
    params.require(:newmicropost).permit(:content)
  end

  def correct_user
    @newmicropost = current_user.newmicroposts.find_by(id: params[:id])
    unless @newmicropost
      redirect_to root_url
    end
  end
end