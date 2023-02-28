Rails.application.routes.draw do
  root to: 'dashboard#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get '/pokemons_purchase/index', to: 'pokemons_purchase#index'
  post '/pokemons_purchase/buy', to: 'pokemons_purchase#buy'
end
