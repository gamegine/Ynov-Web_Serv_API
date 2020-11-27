Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#index'
  resources :movies
  get    '/title'      => 'movies#searchTitle'
  get    '/date'        => 'movies#searchDate'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :movies
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
