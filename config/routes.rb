Rails.application.routes.draw do
  root 'application#index'

  resources :users, only: [:index, :show], format: :json
end
