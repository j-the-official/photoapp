Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "oauth/callback", to: "oauth#callback"
  post "photos/:id/tweet", to: "photos#tweet", as: :tweet_photo

  root "sessions#new"

  resource :session, only: [ :new, :create, :destroy ]

  resources :photos, only: [ :index, :new, :create ]
end
