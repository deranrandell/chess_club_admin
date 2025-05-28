Rails.application.routes.draw do
  root "pages#leaderboard"
  get "/leaderboard", to: "pages#leaderboard", as: :leaderboard
  get "/members", to: "pages#members", as: :members
end
