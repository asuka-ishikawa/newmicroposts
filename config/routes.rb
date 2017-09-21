Rails.application.routes.draw do
  root to: 'toppages#index'
#このルーティングにより、ToppagesControllerとindexアクション、toppages/index.html.erbが必要となる
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
#ユーザ登録用ルーティング
#この後uesrscontrollerを作成する
# command///rails g controller users index show new create

  resources :newmicroposts, only: [:create, :destroy]

end
