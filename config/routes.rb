Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get 'streaming/simple'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # WebSocket chat example:
  get "chat/index"
  get "chat/connect", to: "chat#connect"

  # Robot Finds Kitten example:
  get "game/index", to: "game#index"
  get "game/live", to: "game#live"
end
