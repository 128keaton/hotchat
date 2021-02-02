Rails.application.routes.draw do

  resources :rooms do
    post 'leave', to: 'rooms#leave_room', as: 'leave-room'
    post 'set', to: 'rooms#emit_room', as: 'set-room'
    resources :messages
  end


  root to: 'sessions#index'

  get 'login', to: 'auth#new'
  get 'logout', to: 'auth#logout'
  post 'login', to: 'auth#login', as: 'users'
  get '/rooms_count', to: 'rooms#count_rooms', as: 'count-rooms'

end
