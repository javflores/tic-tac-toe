defmodule GameEngine.Router do
  use GameEngine.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameEngine do
    pipe_through :api

    post "/start", EngineController, :start
    options "/start", EngineController, :preflight

    post "/move/:game_id", EngineController, :move
    options "/move/:game_id", EngineController, :preflight
  end
  
end
