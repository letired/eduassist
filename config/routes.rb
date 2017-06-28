Rails.application.routes.draw do

  root 'pages#home'
  devise_for :users
  resources :school_classes do
    resources :students, only: [ :index, :new, :create ]
    resources :assignments, only: [ :index, :new, :create ]
    member do
      resources :attendances, only: [ :new, :create ]
      get 'attendance/:date', to: 'attendances#show', as: 'attendance'
      get 'attendance/:date/edit', to: 'attendances#edit', as: 'edit_attendance'
      patch 'attendance/:date', to: 'attendances#update', as: 'update_attendance'
      get 'stats', to: 'grades#stats', as: 'stats'
    end
  end
  resources :students, only: [ :update, :destroy, :edit, :show ] do
    member do
      get 'assignments', to: 'assignments#index_students'
      get 'attendances', to: 'attendances#index_students'
    end
  end
  resources :assignments, only: [ :show, :update, :destroy, :edit ]
  resources :grades, only: [ :update ]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :school_classes, only: [ :index, :show, :update, :create, :destroy ] do
        resources :students, only: [ :index, :create ]
        resources :assignments, only: [ :index, :create ]
      end
    end
  end
  # resources :assignments
  # resources :grades, only: [ :create, :update, :destroy ]
  # resources :attendances,
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
