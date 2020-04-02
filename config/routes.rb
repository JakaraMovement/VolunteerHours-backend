Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'pages#index'
  resources :users, only: %i[show update destroy]

  namespace :dashboard do
    get '/', to: 'welcome#index'
    resources :events, only: %i[show index] do
      collection do
        get 'filter_events', as: :filter
      end
      resources :comments
      resources :volunteer_hours
    end
  end
  
  # ------------ ADMIN ROUTES ------------

  namespace :admin do
    get '/', to: 'events#index'
    resources :events do
      resources :comments, only: :index
    end
    resources :regions
    resources :users
    resources :volunteer_hours do
      post 'update_hour', as: :update_hour
      post 'update_status', as: :update_status
    end
  end
end
