Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :home, only: %i[index]
  end

  resources :playlists, only: %i[index show new create edit update] do
    post 'inactive', on: :member
  end

  resources :streamers, only: %i[index show new create edit update] do
    get 'inactive_streamers', on: :collection
  end

  resources :videos, only: %i[index show new create edit update] do
    get 'inactive_videos', on: :collection
  end

  resources :video_categories, only: %i[new create show]

  resources :subscription_plans, only: %i[index show new create], shallow: true do
    post 'add_promotion_ticket', on: :member
    resources :subscription_plan_playlists, only: %i[index new create destroy]
    resources :subscription_plan_streamers, only: %i[new create edit update]
    resources :subscription_plan_values, only: %i[index show new create]

  end
  resources :payment_methods, only: %i[new create show]

  resources :promotion_tickets, only: %i[index new create]
  resources :user_profiles, only: %i[show new create]

  resources :user_subscription_plans, only: %i[new create]

  resources :user_videos, only: %i[new create]
end
