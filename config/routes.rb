Rails.application.routes.draw do
  root 'flat_templates#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :flat_templates
end
