module UsersHelper
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end

#最後のURLを返す。#最後のURLの埋め込み変数　gravatar_id(user.email.downcaseしたものを暗号化) と size 
