Rails.application.routes.draw do
  resources :chats
  # get '/api/chats', to: 'chats#index'
  # post '/api/chats', to: 'chats#create'
end
