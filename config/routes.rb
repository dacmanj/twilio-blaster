Rails.application.routes.draw do
  resources :messages
  resources :group_memberships
  resources :groups
  resources :contacts
  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/notify' => 'twilio#notify'
  post 'twilio/status' => 'twilio#status'
end
