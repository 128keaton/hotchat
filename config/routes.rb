Rails.application.routes.draw do

  resources :rooms do
    resources :messages
  end


  root to: 'sessions#home'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#logout'
  post 'login', to: 'sessions#login', as: 'users'

end
