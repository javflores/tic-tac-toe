use Mix.Config

config :game_engine, GameEngine.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
