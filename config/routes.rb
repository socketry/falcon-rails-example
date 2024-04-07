Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "welcome#index"


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Streaming Example:
  get 'streaming/index'

  # Chat Example:
  get "chat/index"
  get "chat/connect"

  # Game Example:
  get "game/index"
  get "game/live"

  # Job Example:
  get "job/index"
  post "job/execute"
end
