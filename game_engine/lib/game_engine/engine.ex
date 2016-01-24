defmodule GameEngine.Engine do
	use GenServer

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, [], opts)
	end

	def initialize(server, type) do
		GenServer.call(server, {:initialize, type})
	end

	def init([]) do
		state = %{}
		{:ok, state}
	end

	def handle_call({:initialize, type}, _from, state) do
		%{state | status: :init, type: type, board: %{}, x: nil, o: nil}
		new_game = %{board: %{}, x: nil, o: nil}
		{:reply, {:ok, new_game}, state}
	end

end