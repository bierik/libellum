Rails.application.routes.draw do
  root 'flat_templates#index'

  devise_for :users

  resources :flat_templates
  resources :customers do
    patch 'update_route_flat', to: 'customers#update_route_flat', on: :member
    resources :tasks, except: [:update, :destroy, :show]
  end
  resources :tasks, only: [:update, :destroy]
end
