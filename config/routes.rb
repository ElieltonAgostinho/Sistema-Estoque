Rails.application.routes.draw do

  #resource :home
  get 'home/index'

  post '/home', to: 'home#create'


  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
