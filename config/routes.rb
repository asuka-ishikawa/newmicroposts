Rails.application.routes.draw do
  root to: 'toppages#index'
#このルーティングにより、ToppagesControllerとindexアクション、toppages/index.html.erbが必要となる
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :new, :create] do
          #ユーザ登録用ルーティング
          #この後uesrscontrollerを作成する
          # command///rails g controller users index show new create
    member do
      get :followings
      get :followers
    end
  end
  # URLを深掘りするresourcesオプション・member/collection
  # memberはid特定する必要があるか

  resources :newmicroposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

end
