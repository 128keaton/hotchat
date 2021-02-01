Rails.application.routes.draw do

  resources :rooms do
    resources :messages
  end


  root to: 'rooms#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#login'
end
