defmodule GameEngine.Mixfile do
  use Mix.Project

  def project do
    [app: :game_engine,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  def application do
    [mod: {GameEngine, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp aliases do
    [acceptance: ["white_bread.run"]]
  end

  defp deps do
    [{:phoenix, "~> 1.1.3"},
     {:phoenix_html, "~> 2.3"},
     {:gettext, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:poison, "~> 1.5"},
     {:uuid, "~> 1.1" },
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:white_bread, "~> 2.3.0", only: :dev},
     {:mock, "~> 0.1.1", only: :test}]
  end
end
