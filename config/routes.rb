Rails.application.routes.draw do
  root to: 'school_classes#index'
  devise_for :users
  resources :school_classes do
    resources :students, only: [ :index, :new, :create ]
    resources :assignments, only: [ :index, :new, :create ]
  end
  resources :students, only: [ :show, :update, :destroy, :edit ]
  resources :assignments, only: [ :show, :update, :destroy, :edit ]
  # resources :assignments
  # resources :grades, only: [ :create, :update, :destroy ]
  # resources :attendances,
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
