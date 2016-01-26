defmodule GameEngine.Player do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, name, game_type) do
		GenServer.call(server, {:initialize, name, game_type})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:initialize, name, :computer_computer}, _from, state) do
		state = %{name: name, 
				  strategy: :simple}

		{:reply, {:ok, state}, state}
	end
end