Rails.application.routes.draw do
  root to: 'toppages#index'
end
#このルーティングにより、ToppagesControllerとindexアクション、toppages/index.html.erbが必要となる