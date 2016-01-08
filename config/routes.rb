Rails.application.routes.draw do
  resources :message_logs
  resources :messages
  resources :group_memberships
  resources :groups
  resources :contacts

  resources :contacts do
    collection { post :import }
  end

  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  post 'twilio/message' => 'twilio#message'
  post 'twilio/inbound' => 'twilio#inbound'
  post 'twilio/status' => 'twilio#status'
end
