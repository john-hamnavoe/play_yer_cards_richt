Rails.application.routes.draw do
  resources :game_players, except: [:edit, :update]
  resources :game_questions
  resources :games do
    member do
      get :players, to: 'games#players'
      get :players_answered, to: 'games#players_answered'
    end
  end
  resources :questions do
    collection do
      post :import
    end
  end

  root to: 'dashboard#index'
  get 'dashboard/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :episodes do
    resources :created_episodes, only: [:show]
    resources :host_question_episodes, only: [:show, :update]
    resources :host_answer_episodes, only: [:show]
    resources :host_bonus_episodes, only: [:show, :update] do 
      member do
        patch "higher"
        patch "lower"
      end
    end
    resources :host_table_episodes, only: [:show]
    resources :player_board_episodes, only: [:show, :update]    
    resources :finish_episodes, only: [:show]
  end  
end
