Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    resources :home, only: %i[index]
  end

  resources :streamers, only: %i[index show new create]

  resources :subscription_plans, only: %i[index show new create], shallow: true do
    resources :subscription_plan_values
  end
end
