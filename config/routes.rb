Rails.application.routes.draw do
  root "pages#home", as: 'home'

  get 'home' => 'pages#home'
  get 'about' => 'pages#about'
  get 'manual' => 'pages#manual'

  resources :chisquares
end
