# config/routes.rb
Rails.application.routes.draw do
  devise_for :users

  # Admin dashboard route
  get 'admin', to: 'admin#index', as: 'admin_dashboard'
  
  # Route for deleting a user and all their reservations
  delete 'admin/users/:id', to: 'admin#destroy_user', as: 'admin_delete_user'
  
  # Route for deleting an individual reservation
  delete 'admin/reservations/:id', to: 'admin#destroy_reservation', as: 'admin_delete_reservation'

  # Other routes
  resources :bikes, only: [:index] do
    member do
      get 'rent'
      post 'reserve'
    end
  end

  resources :rentals, only: [:index, :destroy]

  root 'bikes#index'
end
