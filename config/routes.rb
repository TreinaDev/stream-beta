Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :home, only: %i[index]
    get 'report', to: 'report#report'
  end

  namespace :user do
    get 'dashboard', to: 'dashboard#dashboard'
    get 'my_subscription_plans', to: 'dashboard#my_subscription_plans'
    get 'my_videos', to: 'dashboard#my_videos'
    get 'purchase_history', to: 'dashboard#purchase_history'
    get 'video_history', to: 'dashboard#video_history'
  end

  resources :playlists, only: %i[index show new create edit update] do
    post 'inactive', on: :member
    get 'search', on: :collection
  end

  resources :streamers, only: %i[index show new create edit update] do
    get 'inactive_streamers', on: :collection
    get 'search', on: :collection
  end

  resources :video_categories, only: %i[new create show index edit update canceled], shallow: true do
    post 'cancel', on: :member
  end

  resources :subscription_plans, only: %i[index show new create edit update], shallow: true do
    post 'inactive', on: :member
    post 'add_promotion_ticket', on: :member
    resources :subscription_plan_playlists, only: %i[index new create destroy]
    resources :subscription_plan_streamers, only: %i[new create edit update]
    resources :subscription_plan_values, only: %i[index show new create], shallow: true do
      post 'cancel', on: :member
    end
  end
  resources :payment_methods, only: %i[new create show]

  resources :promotion_tickets, only: %i[index new create]
  resources :videos, only: %i[index show new create edit update] do
    get 'inactive_videos', on: :collection
    get 'search', on: :collection
    resources :video_histories, only: %i[create destroy]
  end

  resources :user_profiles, only: %i[show new create]

  resources :user_subscription_plans, only: %i[new create]

  resources :user_videos, only: %i[new create]
end
