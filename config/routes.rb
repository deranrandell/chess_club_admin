Rails.application.routes.draw do
  root "pages#leaderboard"
  get "/leaderboard", to: "pages#leaderboard", as: :leaderboard

  resources :members
  resources :matches, only: [ :new, :create ]
end
