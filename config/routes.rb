Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :home, only: %i[index]
  end

  resources :playlists, only: %i[index show new create]

  resources :streamers, only: %i[index show new create edit update]

  resources :video_categories, only: %i[new create show]

  resources :subscription_plans, only: %i[index show new create], shallow: true do
    resources :subscription_plan_values, only: %i[index show new create]
  end

  resources :videos, only: %i[index show new create]

  resources :user_profiles, only: %i[show new create]

  resources :user_subscription_plans, only: %i[new create]
end
