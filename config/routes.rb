Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to:'videos#index'
  get '/videos/new', to: "videos#new"
  get '/videos/:id', to: 'videos#show'
  get '/videos/:id/comment', to: 'comments#new'
  post '/comments', to: 'comments#create'
  post '/videos', to:'videos#create'
  post '/likes', to:'likes#create'
  post '/dislikes', to:'likes#destroy'
  get '/login', to: 'sessions#new'
  get 'auth/:provider', to: 'sessions#new'
  get 'auth/:provider/callback', :to => 'sessions#create'
  get 'auth/failure', :to => 'sessions#failure'
  get '/logout', :to => 'sessions#destroy'
end
