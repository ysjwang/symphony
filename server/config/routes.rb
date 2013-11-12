ScheduleServer::Application.routes.draw do

  root to: "pages#index"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :events, only: [:index, :show, :create, :update, :destroy]
    end
  end

  resources :users
  resources :sessions

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end