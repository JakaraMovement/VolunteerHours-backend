Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'pages#index'


  namespace :dashboard do
    get '/', to: 'welcome#index'
    resources :events, only: %i[show index] do
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
    resources :volunteer_requests
    resources :volunteer_request_accept_reject, only: :update
  end
  # constraints(AdminSubdomain) do
  #   namespace :admin do
  #     get '/', to: 'welcome#index'
  #     resources :events do
  #       resources :comments, only: :index
  #     end
  #     resources :regions
  #     resources :users
  #     resources :volunteer_requests
  #     resources :volunteer_request_accept_reject, only: :update
  #   end
  # end
end
