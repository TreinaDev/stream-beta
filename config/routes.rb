Rails.application.routes.draw do
  devise_for :users
  resources :streamers, only: %i[index show new create]
  resources :subscription_plans, only: %i[index show new create], shallow: true do
    resources :subscription_plan_values
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
