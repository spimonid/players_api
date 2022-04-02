Rails.application.routes.draw do
  get "/players/:id", to: "players#show"

  get "/search", to: "players#search"
end
