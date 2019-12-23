Rails.application.routes.draw do
  root 'flat_templates#index'

  devise_for :users

  resources :flat_templates
end
