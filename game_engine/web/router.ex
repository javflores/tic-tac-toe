defmodule GameEngine.Router do
  use GameEngine.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameEngine do
    pipe_through :api

    post "/initialize", EngineController, :initialize

    post "/start/:game_id", EngineController, :start

    post "/move/:game_id", EngineController, :move
  end
  
end
