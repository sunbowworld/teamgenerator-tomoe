TeamgeneratorTomoe::Application.routes.draw do
  root 'home#index'
  get '/home/index', to: 'home#index'
  get '/home/show_group', to: 'home#show_group'
  post '/home/add', to:'home#add'

  # test route
  # TODO: delete
  post '/team/create', to: 'home#generator'

  resources :steam_user, except: [:edit, :update]
  resources :team
  resources :versus_information
end
