defmodule GameEngine.Endpoint do
  use Phoenix.Endpoint, otp_app: :game_engine

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_game_engine_key",
    signing_salt: "yVdNYKJs"

  plug GameEngine.AllowCrossDomainRequestsPlug

  plug GameEngine.Router
end
