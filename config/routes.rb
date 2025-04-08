Rails.application.routes.draw do
  devise_for :users

  resources :performances, only: [:index] do
    member do
      get 'mark_seen'
      post 'save_seen'
    end
  end

  resources :seen_performances, only: [:index, :destroy]

  root 'performances#index'
end
