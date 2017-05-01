Rails.application.routes.draw do
  root to: 'classes#index'
  devise_for :users
  resources :classes
  resources :students
  # resources :assignments
  # resources :grades, only: [ :create, :update, :destroy ]
  # resources :attendances,
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
