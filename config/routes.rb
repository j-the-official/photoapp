Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "sessions#new"


  resource :session, only: [ :new, :create, :destroy ]

  resources :photos, only: [ :index, :new, :create ]
end
