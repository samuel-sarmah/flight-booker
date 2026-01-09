Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "flights#index"
  resources :flights, only: [ :index ]
  resources :bookings, only: [ :new, :create, :show ] do
    resources :passengers, only: [ :show ]
  end

  # Guest booking lookup
  get "/lookup", to: "bookings_lookup#new", as: :lookup_bookings
  get "/lookup/find", to: "bookings_lookup#show", as: :find_booking

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
