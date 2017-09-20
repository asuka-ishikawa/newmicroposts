Rails.application.config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.skip_routes true
end
#自分で作成
#config/initializers/ フォルダ内の初期設定用の Ruby ファイルは Rails 起動時に自動的に全てが読み込まれる
#これで、CSS, JS, Helper 関係のファイルは自動生成されません