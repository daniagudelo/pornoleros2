Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  get '/listing', to: 'scenes#listing'
  
  resources :scenes
end
