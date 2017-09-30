class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  # デフォルトではController から Helper のメソッドを使うことはできないため
end

private

def require_user_logged_in
  unless logged_in?
    redirect_to login_url
  end
end

def require_user_logged_in
  unless logged_in?
    redirect_to login_url
  end
end


# 数えるよ。(users_controllerとusers_viewで使うよ)
def counts(user)
  @count_newmicroposts = user.newmicroposts.count
  @count_followings = user.followings.count
  @count_followers = user.followers.count
  @count_favoritings = user.favoritings.count
end

# def counts(newmicropost)
#   @count_favoritings = user.favoritings.count
# end