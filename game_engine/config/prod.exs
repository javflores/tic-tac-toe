use Mix.Config

config :game_engine, GameEngine.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com", port: 80]

config :logger, level: :info

import_config "prod.secret.exs"
