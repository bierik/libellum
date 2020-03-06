Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users, controllers: {
    invitations: 'users/invitations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
  }

  resources :flat_templates
  resources :customers do
    patch 'update_route_flat', to: 'customers#update_route_flat', on: :member
    resources :tasks, except: [:update, :destroy, :show]
  end
  resources :tasks, only: [:update, :destroy, :index]
end
