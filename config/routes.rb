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
    end
  end
  resources :students, only: [ :update, :destroy, :edit, :show ] do
    member do
      get 'assignments', to: 'students#show_assignments'
      get 'grades', to: 'students#show_grades'
      patch 'grades', to: 'students#show_grades'
    end
  end
  resources :assignments, only: [ :show, :update, :destroy, :edit ]
  # resources :assignments
  # resources :grades, only: [ :create, :update, :destroy ]
  # resources :attendances,
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
