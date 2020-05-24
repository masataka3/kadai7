Rails.application.routes.draw do
	devise_for :users
  resources :users,only: [:show,:edit,:update,:index]
  root 'home#top'
  get 'home/about'
  get '/map_request', to: 'maps#map', as: 'map_request'

  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
  	resources :maps,only: [:index]
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
