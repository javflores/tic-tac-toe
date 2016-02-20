defmodule GameEngine.PlayersSupervisor do
  use Supervisor

    def start_link(opts \\ []) do
      Supervisor.start_link(__MODULE__, :ok, opts)
    end

    def init(:ok) do
      children = [
          worker(GameEngine.Player, [[name: :o]], id: :o),
          worker(GameEngine.Player, [[name: :x]], id: :x)
      ]

      supervise(children, strategy: :one_for_one)
    end
end
