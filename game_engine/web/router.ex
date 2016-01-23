defmodule GameEngine.Router do
  use GameEngine.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameEngine do
    pipe_through :api

    post "/initiate", EngineController, :initiate
  end
  
end
