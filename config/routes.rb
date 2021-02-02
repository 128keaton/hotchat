Rails.application.routes.draw do

  resources :rooms do
    delete 'leave', to: 'rooms#leave_room'
    resources :messages
  end


  root to: 'rooms#index'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#logout'
  post 'login', to: 'sessions#login', as: 'users'

end
