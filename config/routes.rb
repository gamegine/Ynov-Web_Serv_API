Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  root to: 'movies#index'
  resources :movies
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :movies
      resources :watches
      get    'search/title'      => 'searches#searchTitle'
      get    'search/date'        => 'searches#searchDate'
      get    'search/rating'        => 'searches#searchRating'
      get    'search/complete'        => 'searches#searchComplete'
    end
  end
  # swagger
  get '/api-docs.json' => 'apidocs#index'
  get '/swagger' => redirect('/swagger-ui/index.html?url=/api-docs.json')
  get    'token'      => 'token#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
