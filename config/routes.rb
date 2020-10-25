Rails.application.routes.draw do
  resources :games
  resources :questions do
    collection do
      post :import
    end
  end
  root to: 'dashboard#index'
  get 'dashboard/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
