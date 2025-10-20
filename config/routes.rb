Rails.application.routes.draw do
  get "passengers/show"
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "flights#index"
  resources :flights, only: [ :index ]
  resources :bookings, only: [ :new, :create, :show ] do
    resources :passenges, only: [ :show ]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
