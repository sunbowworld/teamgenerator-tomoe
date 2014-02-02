TeamgeneratorTomoe::Application.routes.draw do
  root 'home#index'
  get  '/home/index', to: 'home#index'
  get  '/home/show_group', to: 'home#show_group'
  post '/home/add', to: 'home#add'
  #resources :steam_user, except: [:edit, :update]
  
  # teamコントローラ (チーム関連)
  get    '/team', to: 'team#index'
  post   '/team', to: 'team#create'
  get    '/team/:id', to: 'team#show', constraints: {id: /\d+/}
  get    '/team/generate', to: 'team#generate'
  
  # battleコントローラ (対戦結果)
  get    '/battle', to: 'battle#index'
  get    '/battle/new/:json', to: 'battle#new'
  post   '/battle', to: 'battle#create'
  get    '/battle/:id/edit', to: 'battle#edit', constraints: {id: /\d+/}
  put    '/battle/:id', to: 'battle#update', constraints: {id: /\d+/}
  get    '/battle/:id', to: 'battle#show', constraints: {id: /\d+/}
  get    '/battle/list_empty', to: 'battle#list_empty'
end
